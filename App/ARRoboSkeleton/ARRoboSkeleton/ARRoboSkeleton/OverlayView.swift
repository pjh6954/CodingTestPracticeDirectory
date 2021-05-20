//
//  OverlayView.swift
//  ARRoboSkeleton
//
//  Created by Dahnyue on 2021/05/10.
//

import Foundation
import UIKit

struct Line {
  let from: CGPoint
  let to: CGPoint
}

struct Person {
    var joints: [CGPoint]
    var bones: [Line]
}

class OverlayView: UIView {
    
    var joints = [CGPoint]()
    var lines = [Line]()
    
    override func draw(_ rect: CGRect) {
        for joint in joints {
            drawJoint(of: joint, .red)
        }
        
        for line in lines {
            drawLine(of: line, .red)
        }
    }
    
    func drawJoint(of joint: CGPoint, _ color : UIColor = .white) {
      let dotRect = CGRect(
        x: joint.x - Traits.dot.radius / 2, y: joint.y - Traits.dot.radius / 2,
        width: Traits.dot.radius, height: Traits.dot.radius)
      let dotPath = UIBezierPath(ovalIn: dotRect)

      color.setFill()
      dotPath.fill()
    }
    
    func drawLine(of line: Line, _ color: UIColor = UIColor.white, _ width: CGFloat = 1.0) {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: line.from.x, y: line.from.y))
        linePath.addLine(to: CGPoint(x: line.to.x, y: line.to.y))
        linePath.close()
        
        linePath.lineWidth = width
        color.setStroke()
        
        linePath.stroke()
    }
    
    func clear() {
      self.joints = []
      self.lines = []
    }
}

private enum Traits {
  static let dot = (radius: CGFloat(5), color: UIColor.green)
  static let line = (width: CGFloat(1.0), color: UIColor.green)
}

enum CharacterPart :String, CaseIterable {
    case ROOT = "root" // 0
    case SPINE1 = "hips_joint"
    case SPINE2 = "spine_1_joint"
    case SPINE3 = "spine_2_joint"
    case SPINE4 = "spine_3_joint"
    case SPINE5 = "spine_4_joint"
    case SPINE6 = "spine_5_joint"
    case SPINE7 = "spine_6_joint" // 7
    case NECK1 = "spine_7_joint" // 8
    case NECK2 = "neck_1_joint"
    case NECK3 = "neck_2_joint"
    case NECK4 = "neck_3_joint"
    case HEAD = "neck_4_joint"
    case NOSE = "nose_joint"
    case LEFT_EYE = "left_eye_joint"
    case RIGHT_EYE = "right_eye_joint" // 15
    
    case LEFT_WRIST = "left_hand_joint" // 16
    case RIGHT_WRIST = "right_hand_joint"
    case LEFT_ELBOW = "left_forearm_joint"
    case RIGHT_ELBOW = "right_forearm_joint"
    case RIGHT_SHOULDER = "right_arm_joint"
    case LEFT_SHOULDER = "left_arm_joint"
    case RIGHT_CLAVICLE = "right_shoulder_1_joint"
    case LEFT_CLAVICLE = "left_shoulder_1_joint" // 23
    
    case LEFT_HIP = "left_upLeg_joint" // 24
    case RIGHT_HIP = "right_upLeg_joint"
    case LEFT_KNEE = "left_leg_joint"
    case RIGHT_KNEE = "right_leg_joint"
    case LEFT_ANKLE = "left_foot_joint"
    case RIGHT_ANKLE = "right_foot_joint"
    case LEFT_TOES = "left_toes_joint"
    case RIGHT_TOES = "right_toes_joint"
    case LEFT_TOESEND = "left_toesEnd_joint"
    case RIGHT_TOESEND = "right_toesEnd_joint" // 33

    /// List of lines connecting each part.
    static let lines = [
        (from: CharacterPart.SPINE1, to: CharacterPart.SPINE2), // 척추 0-1
        (from: CharacterPart.SPINE2, to: CharacterPart.SPINE3), // 척추 1-2
        (from: CharacterPart.SPINE3, to: CharacterPart.SPINE4), // 척추 2-3
        (from: CharacterPart.SPINE4, to: CharacterPart.SPINE5), // 척추 3-4
        (from: CharacterPart.SPINE5, to: CharacterPart.SPINE6), // 척추 4-5
        (from: CharacterPart.SPINE6, to: CharacterPart.SPINE7), // 척추 5-6
        (from: CharacterPart.SPINE7, to: CharacterPart.NECK1), // 척추 6-7
        (from: CharacterPart.HEAD, to: CharacterPart.NOSE), // 머리 - 코
        (from: CharacterPart.LEFT_EYE, to: CharacterPart.RIGHT_EYE), // 양 눈
        (from: CharacterPart.LEFT_CLAVICLE, to: CharacterPart.LEFT_SHOULDER), // 좌 어깨
        (from: CharacterPart.RIGHT_CLAVICLE, to: CharacterPart.RIGHT_SHOULDER), // 우 어깨
        (from: CharacterPart.LEFT_SHOULDER, to: CharacterPart.LEFT_ELBOW), // 좌 상완
        (from: CharacterPart.RIGHT_SHOULDER, to: CharacterPart.RIGHT_ELBOW), // 우 상완
        (from: CharacterPart.LEFT_ELBOW, to: CharacterPart.LEFT_WRIST), // 좌 하완
        (from: CharacterPart.RIGHT_ELBOW, to: CharacterPart.RIGHT_WRIST), // 우 하완
        (from: CharacterPart.RIGHT_HIP, to: CharacterPart.RIGHT_KNEE), // 우 허벅지
        (from: CharacterPart.LEFT_HIP, to: CharacterPart.LEFT_KNEE), // 좌 허벅지
        (from: CharacterPart.RIGHT_KNEE, to: CharacterPart.RIGHT_ANKLE), // 우 정강이
        (from: CharacterPart.LEFT_KNEE, to: CharacterPart.LEFT_ANKLE), // 좌 정강이
        (from: CharacterPart.RIGHT_ANKLE, to: CharacterPart.RIGHT_TOES), // 우 발
        (from: CharacterPart.LEFT_ANKLE, to: CharacterPart.LEFT_TOES), // 좌 발
        (from: CharacterPart.RIGHT_TOES, to: CharacterPart.RIGHT_TOESEND), // 우 발가락
        (from: CharacterPart.LEFT_TOES, to: CharacterPart.LEFT_TOESEND), // 좌 발가락
    ]
}

// MARK: - Custom Errors
enum PostprocessError: Error {
  case missingCharacterPart(of: CharacterPart)
}
