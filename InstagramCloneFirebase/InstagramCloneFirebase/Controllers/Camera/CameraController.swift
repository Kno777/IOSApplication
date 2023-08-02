//
//  CameraController.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 02.08.23.
//

import UIKit
import AVFoundation

class CameraController: UIViewController {
    
    private lazy var capturePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "capture_photo"), for: .normal)
        button.addTarget(self, action: #selector(handelCapturePhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "right_arrow_shadow"), for: .normal)
        button.addTarget(self, action: #selector(handelDismiss), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        
        setupCameraButtons()
    }
    
    @objc private func handelDismiss() {
        dismiss(animated: true)
    }
    
    @objc private func handelCapturePhoto() {
        print("Taking photo...")
    }
    
    fileprivate func setupCameraButtons() {
        view.addSubview(capturePhotoButton)
        view.addSubview(dismissButton)
                
        capturePhotoButton.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -24, paddingRight: 0, width: 80, height: 80)
        capturePhotoButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: -8, width: 50, height: 50)
    }
    
    fileprivate func setupCaptureSession() {
        
        let captureSession = AVCaptureSession()
        
        // 1. setup inputs
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
                
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            
        } catch {
            print("Failed to capture device inputs: ", error)
            return
        }
        
        // 2. setup outputs
        
        let output = AVCapturePhotoOutput()
        if captureSession.canAddOutput(output) {
            captureSession.addOutput(output)
        }
        
        // 3. setup outputs preview
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .background).async {
            captureSession.startRunning()
        }
    }
}
