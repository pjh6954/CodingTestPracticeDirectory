//
//  ViewController.swift
//  ARRoboSkeleton
//
//  Created by DahNyue on 2021/05/10.
//

import UIKit
import RealityKit
import ARKit
import Combine

class ViewController: UIViewController, ARSessionDelegate {
    
    @IBOutlet var arView: ARView!
    @IBOutlet weak var overlayView: OverlayView!
    @IBOutlet weak var robotSwitch: UISwitch!
    
    // The 3D character to display.
    var character: BodyTrackedEntity?
    let characterOffset: SIMD3<Float> = [0, 0, 0] // Offset the character by one meter to the left
    let characterAnchor = AnchorEntity()
    var arViewSize: CGSize?
    var overlayViewSize: CGSize?
    
    var isShowRobot: Bool = true {
        didSet {
            if isShowRobot {
                self.arView.scene.addAnchor(characterAnchor)
            } else {
                self.arView.scene.removeAnchor(characterAnchor)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.arViewSize = self.arView.frame.size
        self.overlayViewSize = self.overlayView.frame.size
        
        arView.session.delegate = self
        
        // If the iOS device doesn't support body tracking, raise a developer error for
        // this unhandled case.
        guard ARBodyTrackingConfiguration.isSupported else {
            let alertController = UIAlertController(title: "Not supported Device", message: "This feature is only supported on devices with an A12 chip", preferredStyle: .alert)
            let doneAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                fatalError("This feature is only supported on devices with an A12 chip")
            })
            alertController.addAction(doneAction)
            self.present(alertController, animated: true)
            return
        }

        // Run a body tracking configration.
        let configuration = ARBodyTrackingConfiguration()
        arView.session.run(configuration)
        
        arView.scene.addAnchor(characterAnchor)
        
        createCharacter()
        
    }
    
    func createCharacter() {
        // Asynchronously load the 3D character.
        var cancellable: AnyCancellable? = nil
        cancellable = Entity.loadBodyTrackedAsync(named: "character/robot").sink(
            receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error: Unable to load model: \(error.localizedDescription)")
                }
                cancellable?.cancel()
        }, receiveValue: { (character: Entity) in
            if let character = character as? BodyTrackedEntity {
                // Scale the character to human size
                character.scale = [1.0, 1.0, 1.0]
                // print("* character.jointNames.count", character.jointNames.count)
                self.character = character
                cancellable?.cancel()
            } else {
                print("Error: Unable to load model as BodyTrackedEntity")
            }
        })
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        // print("* anchor count", anchors.count) // 1
        self.clearPerson()
        for anchor in anchors {
            guard let bodyAnchor = anchor as? ARBodyAnchor else { continue }
            
            var person = Person(joints: [], bones: [])
            var bodyPartToJointMap = [CharacterPart: CGPoint]()
            
            for jointName in bodyAnchor.skeleton.definition.jointNames {
                let jointType = ARSkeleton.JointName(rawValue: jointName)
                // print("jointName", jointName)
                // print("jointType", jointType)
                if let transform = bodyAnchor.skeleton.modelTransform(for: jointType) {
                    var matrix = SCNMatrix4(transform)
                    matrix = SCNMatrix4Mult(matrix, SCNMatrix4(bodyAnchor.transform))
                    let position = SCNVector3(matrix.m41, matrix.m42, matrix.m43)
                    guard let cgPositionPoint = arView.project(SIMD3<Float>(position)) else { return }
                    
                    for (_, part) in CharacterPart.allCases.enumerated() {
                        if jointName.contains(part.rawValue) {
                            if part.rawValue == "root" {
                                // print("* \(jointName) :: \(position)")
                                // print("** \(jointName) : \(cgPositionPoint)")
                            }
                            bodyPartToJointMap[part] = cgPositionPoint
                            person.joints.append(cgPositionPoint)
                        }
                    }
                }
            }
            
            do {
                try person.bones = CharacterPart.lines.map { map throws -> Line in
                    guard let from = bodyPartToJointMap[map.from] else {
                        throw PostprocessError.missingCharacterPart(of: map.from)
                    }
                    guard let to = bodyPartToJointMap[map.to] else {
                        throw PostprocessError.missingCharacterPart(of: map.to)
                    }
                    return Line(from: from, to: to)
                }
            } catch PostprocessError.missingCharacterPart(let missingPart) {
                print("Postprocessing error: %@ is missing.", missingPart.rawValue)
                continue
            } catch {
                print("Postprocessing error: %@", error.localizedDescription)
                continue
            }
            
            self.drawPerson(of: person)
                
            // Update the position of the character anchor's position.
            let bodyPosition = simd_make_float3(bodyAnchor.transform.columns.3)
            characterAnchor.position = bodyPosition + characterOffset
            // Also copy over the rotation of the body anchor, because the skeleton's pose
            // in the world is relative to the body anchor's rotation.
            characterAnchor.orientation = Transform(matrix: bodyAnchor.transform).rotation
   
            if let character = character, character.parent == nil {
                // Attach the character to its anchor as soon as
                // 1. the body anchor was detected and
                // 2. the character was loaded.
                print("* characterAnchor", characterAnchor)
                let rootGuardBoxEntity = ModelEntity(mesh: MeshResource.generateBox(size: 0.15), materials: [SimpleMaterial(color: UIColor.black, isMetallic: false)])
                characterAnchor.addChild(character)
                characterAnchor.addChild(rootGuardBoxEntity)
            }
        }
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        print("Camera TrackingState: \(camera.trackingState)")
        // Ex)
        // If you put the device down on the ground with the camera down
        // - limited((extension in ARKit):__C.ARCamera.TrackingState.Reason.insufficientFeatures)
        // If you move the device fast
        // - limited((extension in ARKit):__C.ARCamera.TrackingState.Reason.excessiveMotion)
        // Anyway, When the device is ready
        // - normal
        self.clearPerson()
    }
    
    func drawPerson(of person: Person) {
        self.overlayView.joints = person.joints
        self.overlayView.lines = person.bones
        self.overlayView.setNeedsDisplay()
    }
    
    func clearPerson() {
        self.overlayView.clear()
        self.overlayView.setNeedsDisplay()
    }
    
    @IBAction func switchedRobotSwitch(_ sender: UISwitch) {
        self.isShowRobot = sender.isOn
    }
}

