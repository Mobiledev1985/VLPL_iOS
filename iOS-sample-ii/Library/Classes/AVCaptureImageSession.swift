//
//  AVCaptureImageSession.swift
//  Camera
//
//  Created by SOTSYS123 on 10/10/19.
//  Copyright © 2019 Rizwan. All rights reserved.
//

import UIKit
import AVFoundation

protocol CameraCaptureSessionProtocol  {
    func capturedImage(image:UIImage?,error:Error?)
}

class AVCaptureImageSession: UIView {
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var capturePhotoOutput: AVCapturePhotoOutput?
    var delegate : CameraCaptureSessionProtocol?
    var captureDevice : AVCaptureDevice?
    
    var isFlashOn : Bool = false {
        didSet {
            //            self.toggleTorch(on: isFlashOn)
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
    }
    
    /*
     private func toggleTorch(on: Bool) {
     guard let device = AVCaptureDevice.default(for: .video) else { return }
     
     if device.hasTorch {
     do {
     try device.lockForConfiguration()
     
     if on == true {
     device.torchMode = .on
     } else {
     device.torchMode = .off
     }
     
     device.unlockForConfiguration()
     } catch {
     print("Torch could not be used")
     }
     } else {
     print("Torch is not available")
     }
     }
     */
    func toggleCameraRear() {
        
        captureSession?.beginConfiguration()
        let currentInput = captureSession?.inputs.first as? AVCaptureDeviceInput
        if let currentInput = currentInput {
            captureSession?.removeInput(currentInput)
        }
        
//        let newCameraDevice = currentInput?.device.position == .back ? getCamera(with: .front) : getCamera(with: .back)
//        if let newCameraDevice = newCameraDevice,let newVideoInput = try? AVCaptureDeviceInput(device: newCameraDevice) {
//            captureSession?.addInput(newVideoInput)
//        }
//        
        captureSession?.commitConfiguration()
    }
    
    
    func focus(at point: CGPoint) {
        guard let device = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        guard device.isFocusPointOfInterestSupported, device.isExposurePointOfInterestSupported else {
            return
        }
        
        do {
            try device.lockForConfiguration()
            
            device.focusPointOfInterest = point
            device.exposurePointOfInterest = point
            
            device.focusMode = .continuousAutoFocus
            device.exposureMode = .continuousAutoExposure
            
            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    
    func setUpCameraSession() {
        
        if let captureSession = captureSession {
            if !captureSession.isRunning {
                captureSession.startRunning()
            }
            return
        }
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            if let vc = self.parentViewController {
                vc.showAlert(title: "", message: "No video device found")
            }
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous deivce object
            
            self.captureDevice = captureDevice
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object
            captureSession = AVCaptureSession()
            
            // Set the input devcie on the capture session
            captureSession?.addInput(input)
            
            // Get an instance of ACCapturePhotoOutput class
            capturePhotoOutput = AVCapturePhotoOutput()
            capturePhotoOutput?.isHighResolutionCaptureEnabled = true
            
            // Set the output on the capture session
            captureSession?.addOutput(capturePhotoOutput!)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the input device
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            
            
            
            //Initialise the video preview layer and add it as a sublayer to the viewPreview view's layer
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = self.layer.bounds
            self.layer.addSublayer(videoPreviewLayer!)
            do {
                try captureDevice.lockForConfiguration()
                
                captureDevice.focusMode = .continuousAutoFocus
                captureDevice.exposureMode = .continuousAutoExposure
                
                captureDevice.unlockForConfiguration()
            } catch {
                print(error)
            }
            //start video capture
            captureSession?.startRunning()
            
            
            
            //Initialize QR Code Frame to highlight the QR code
            
        } catch {
            //If any error occurs, simply print it out
            print(error)
            return
        }
    }
    
    func stopCameraSession() {
        if let isValid = captureSession?.isRunning,isValid {
            captureSession?.stopRunning()
        }
    }
    
    func captureImage() {
        guard let capturePhotoOutput = self.capturePhotoOutput else { return }
        
        // Get an instance of AVCapturePhotoSettings class
        let photoSettings = AVCapturePhotoSettings()
        
        // Set photo settings for our need
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = isFlashOn ? .on : .off
        if isFlashOn,capturePhotoOutput.supportedFlashModes.contains(.on) {
            photoSettings.flashMode = .on
        }else {
            photoSettings.flashMode = .off
        }
        
        // Call capturePhoto method by passing our photo settings and a delegate implementing AVCapturePhotoCaptureDelegate
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
}

@available(iOS 11.0, *)
extension AVCaptureImageSession : AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else {
                print("Error capturing photo: \(String(describing: error))")
                delegate?.capturedImage(image: nil,error: error)
                return
        }
        
        // Convert photo same buffer to a jpeg image data by using AVCapturePhotoOutput
        guard let imageData = photo.fileDataRepresentation() else {
            delegate?.capturedImage(image: nil,error: error)
            return
        }
        
        // Initialise an UIImage with our image data
        let capturedImage = UIImage.init(data: imageData , scale: 1.0)
        if let image = capturedImage {
            
            delegate?.capturedImage(image: image,error: error)
            captureSession?.stopRunning()
            //            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }else{
            delegate?.capturedImage(image: nil,error: error)
        }
    }
    /*
    func photoOutput(_ captureOutput: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
                     previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
                     resolvedSettings: AVCaptureResolvedPhotoSettings,
                     bracketSettings: AVCaptureBracketedStillImageSettings?,
                     error: Error?) {
        // Make sure we get some photo sample buffer
        guard error == nil,
            let photoSampleBuffer = photoSampleBuffer else {
                print("Error capturing photo: \(String(describing: error))")
                delegate?.capturedImage(image: nil,error: error)
                return
        }
        
        // Convert photo same buffer to a jpeg image data by using AVCapturePhotoOutput
        guard let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer) else {
            delegate?.capturedImage(image: nil,error: error)
            return
        }
        
        // Initialise an UIImage with our image data
        let capturedImage = UIImage.init(data: imageData , scale: 1.0)
        if let image = capturedImage {
            
            delegate?.capturedImage(image: image,error: error)
            captureSession?.stopRunning()
            //            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }else{
            delegate?.capturedImage(image: nil,error: error)
        }
    }
    */
    private func getCamera(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        guard let devices = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: AVMediaType.video, position: position)  else {
            return nil
        }
        
        return devices
    }
    
    
}


extension UIInterfaceOrientation {
    var videoOrientation: AVCaptureVideoOrientation? {
        switch self {
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeRight: return .landscapeRight
        case .landscapeLeft: return .landscapeLeft
        case .portrait: return .portrait
        default: return nil
        }
    }
}

