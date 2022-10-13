//
//  CustomCameraVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 31/01/22.
//

import UIKit
import AVFoundation

protocol didTakeCustomPhoto_protocol {
    func didTakeCustomPhoto_protocol(image_: UIImage)
}

class CustomCameraVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var imgFlash: UIImageView!
    @IBOutlet weak var viewCancel: UIView!
    @IBOutlet weak var imgRetakeCancel: UIImageView!
    @IBOutlet weak var imgConfirmation: UIImageView!
    @IBOutlet weak var imgTakePhoto: UIImageView!
    @IBOutlet weak var btnTakePhoto: UIButton!
    
    
    //MARK: Veriable
    var delegate_didTakeCustomPhoto: didTakeCustomPhoto_protocol?
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var headerTitle = ""
    var isConfirmationView = false
    var avCaptureDevicePosition: AVCaptureDevice.Position = .front
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTakeImageUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        lblHeaderTitle.text = headerTitle
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        
        
        
        //7
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        else {
            print("Unable to access back camera!")
            return
        }
        guard let device_ = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: avCaptureDevicePosition) else { fatalError("no front camera. but don't all iOS 10 devices have them?")
            
        }
        
        
        //8
        do {
            let input = try AVCaptureDeviceInput(device: device_)
            //Step 9
            stillImageOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    
    
    func setupLivePreview() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        cameraView.layer.addSublayer(videoPreviewLayer)
        
        //Step12
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            //Step 13
            
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.cameraView.bounds
            }
        }
    }
    
    func setTakeImageUI(){
        viewCancel.isHidden = true
        imgConfirmation.isHidden = true
        imgFlash.image = UIImage(named: "ic_no_flash", in: bundleIdentifireGlob, with: nil)
        isConfirmationView = false
        imgTakePhoto.image = UIImage(named: "ic_takephoto", in: bundleIdentifireGlob, with: nil)
        btnTakePhoto.isUserInteractionEnabled = true
    }
    func setConfirmationUI(){
        viewCancel.isHidden = false
        imgConfirmation.isHidden = false
        imgFlash.image = UIImage(named: "ic_done_white", in: bundleIdentifireGlob, with: nil)
        isConfirmationView = true
        imgTakePhoto.image = UIImage(named: "ic_taked_photo", in: bundleIdentifireGlob, with: nil)
        btnTakePhoto.isUserInteractionEnabled = false
    }
    
    func toggleFlash() {
        if let device = AVCaptureDevice.default(for: AVMediaType.video){
            if (device.hasTorch) {
                do {
                    try device.lockForConfiguration()
                    if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                        device.torchMode = AVCaptureDevice.TorchMode.off
                        imgFlash.image = UIImage(named: "ic_no_flash", in: bundleIdentifireGlob, with: nil)
                    } else {
                        do {
                            try device.setTorchModeOn(level: 1.0)
                            imgFlash.image = UIImage(named: "ic_flash", in: bundleIdentifireGlob, with: nil)
                        } catch {
                            print(error)
                        }
                    }
                    device.unlockForConfiguration()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    //MARK: @IBAction
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnFlash(_ sender: Any) {
        if isConfirmationView{
            if let img_ = imgConfirmation.image{
                delegate_didTakeCustomPhoto?.didTakeCustomPhoto_protocol(image_: img_)
            }
            self.dismiss(animated: true, completion: nil)
        }else{
            toggleFlash()
        }
    }
    @IBAction func btnRetakeCancel(_ sender: Any) {
        setTakeImageUI()
    }
    @IBAction func btnTakePhoto(_ sender: Any) {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
}

extension CustomCameraVC: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
        else { return }
        
        if let image_ = UIImage(data: imageData){
            imgConfirmation.image = image_
            setConfirmationUI()
        }
    }
    
}

extension CustomCameraVC: didTakeCustomPhoto_protocol{
    func didTakeCustomPhoto_protocol(image_: UIImage){
        
    }
}
