//
//  ViewController.swift
//  CustomCameraApp
//
//  Created by Dannian Park on 2021/07/26.
//

import UIKit

import AVFoundation

class ViewController: UIViewController {
    
    // Capture Session
    private var session : AVCaptureSession?
    // Photo output
    private let output : AVCapturePhotoOutput = .init()
    // Video Preview
    private let previewLayer : AVCaptureVideoPreviewLayer = .init()
    // Shutter Button
    private let shutterBtn : UIButton = {
        let btn : UIButton = .init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        btn.layer.cornerRadius = 50
        btn.layer.borderWidth = 10
        btn.layer.borderColor = UIColor.white.cgColor
        return btn
    }()
    // clear sticker image view
    private var stickerView : UIView?
    private var stickerImageView : UIImageView?
    private var stickerImage : UIImage? = UIImage(named: "apple")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        //previewLayer.backgroundColor = UIColor.red.cgColor
        view.layer.addSublayer(previewLayer)
        
        setStickerView()
        setStickerImageView()
        
        view.addSubview(shutterBtn)
        
        
        self.checkCameraPermission()
        
        shutterBtn.addTarget(self, action: #selector(didTakePhoto), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        
        shutterBtn.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height - 100)
    }
    
    private func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .authorized:
            setCamera()
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] result in
                guard result else {
                    return
                }
                DispatchQueue.main.async {
                    self?.setCamera()
                }
            }
            break
        case .restricted:
            break
        case .denied:
            break
        @unknown default:
            break
        }
    }
    
    private func setStickerView() {
        let overView = UIView(frame: .zero)
        overView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(overView)
        NSLayoutConstraint.activate([
            .init(item: overView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
            .init(item: overView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
            .init(item: overView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0),
            .init(item: overView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        ])
        self.stickerView = overView
    }
    
    private func setStickerImageView() {
        guard let img = self.stickerImage else {
            return
        }
        let sizeOfImage = img.size
        print("Size of image : \(sizeOfImage)")
        let imgView = UIImageView(frame: .init(x: self.view.center.x - (sizeOfImage.width / 2), y: self.view.center.y - (sizeOfImage.height / 2), width: sizeOfImage.width, height: sizeOfImage.height))
        imgView.image = img
        self.stickerView?.addSubview(imgView)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleImageMove(sender:)))
        imgView.addGestureRecognizer(panGesture)
        imgView.isUserInteractionEnabled = true
        self.stickerImageView = imgView
    }
    
    private func setCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                
                session.startRunning()
                self.session = session
            }
            catch {
                
            }
        }
    }
    
    @objc private func handleImageMove(sender : UIPanGestureRecognizer) { // sticker 이미지 움직임
        if (sender.state == UIGestureRecognizer.State.changed) {
            var center = sender.view?.center
            let translation = sender.translation(in: sender.view)
            center = CGPoint(x: center!.x + translation.x, y: center!.y + translation.y)
            sender.view?.center = center!
            sender .setTranslation(CGPoint.zero, in: sender.view)
        }
    }
}

extension ViewController {
    @objc private func didTakePhoto() {
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
}

extension ViewController : AVCapturePhotoCaptureDelegate { // 이미지 처리.
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        var image = UIImage(data: data)
        if let _image = image, let sticker = self.stickerView {
            //image = image?.imageWithView(view: sticker)
            image = UIImage.imageMergeWithView(image: _image, view: sticker)
        }
        
        session?.stopRunning()
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        view.addSubview(imageView)
        
    }
}

extension UIImage {
    // 테스트용. sticker만 그려지는 함수.
    func imageWithView(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    class func imageMergeWithView(image: UIImage, view: UIView) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img
    }
}
