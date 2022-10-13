//
//  SignSignatureVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 15/02/22.
//

import UIKit

protocol didSignSignature_protocol {
    func didSignSignature_protocol(img: UIImage)
}
class SignSignatureVC: UIViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var lblUploadNewSignature: UILabel!
    @IBOutlet weak var viewSignature: YPDrawSignatureView!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var imgClear: UIImageView!
    
    
    //MARK: - Veriable
    var delegate_didSignSignature_protocol: didSignSignature_protocol?
   
    
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        
        //--
        //        let value = UIInterfaceOrientation.landscapeRight.rawValue
        //        UIDevice.current.setValue(value, forKey: "orientation")
        //        setNeedsUpdateOfSupportedInterfaceOrientations()
        
        //--
        viewSignature.delegate = self
        btnClear.isHidden = true
        imgClear.isHidden = true
        
        self.rotateToLandsScapeDevice()
        //setDeviceOrientation(orientation: .landscapeRight)
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.rotateToPotraitScapeDevice()
        //setDeviceOrientation(orientation: .portrait)

    }
    
    //    override func viewDidLayoutSubviews() {
    //
    //        let value = UIInterfaceOrientation.landscapeRight.rawValue
    //        UIDevice.current.setValue(value, forKey: "orientation")
    //        setNeedsUpdateOfSupportedInterfaceOrientations()
    //    }
    //
    //    override func viewDidDisappear(_ animated: Bool) {
    //        //--
    //        let value = UIInterfaceOrientation.portrait.rawValue
    //        UIDevice.current.setValue(value, forKey: "orientation")
    //        setNeedsUpdateOfSupportedInterfaceOrientations()
    //    }
    
    
    func rotateToLandsScapeDevice(){
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.myOrientation = .landscapeRight
        
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        UIView.setAnimationsEnabled(false)
         
        //view.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
    }
    
    func rotateToPotraitScapeDevice(){
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.myOrientation = .portrait
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        UIView.setAnimationsEnabled(false)
    }
    
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        lblInfo.text = Localize(key: "Sign with your finger here.")
        lblUploadNewSignature.text = Localize(key: "UPLOAD NEW SIGNATURE")
        
    }
    
    //MARK: - @IBAction
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnUploadNewSignature(_ sender: Any) {
        if let signatureImage = self.viewSignature.getSignature(scale: 10) {
            //--
            delegate_didSignSignature_protocol?.didSignSignature_protocol(img: signatureImage)
            
            //--
            self.viewSignature.clear()
            
            //--
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func btnClear(_ sender: Any) {
        viewSignature.clear()
        btnClear.isHidden = true
        imgClear.isHidden = true
        lblInfo.isHidden = false
    }
    
    
}

extension SignSignatureVC: YPSignatureDelegate{
    func didStart(_ view : YPDrawSignatureView) {
        print("Started Drawing")
        lblInfo.isHidden = true
        imgClear.isHidden = true
    }
    func didFinish(_ view : YPDrawSignatureView) {
        print("Finished Drawing")
        btnClear.isHidden = false
        imgClear.isHidden = false
    }
    
}

extension UIViewController {
    
    func setDeviceOrientation(orientation: UIInterfaceOrientationMask) {
        if #available(iOS 16.0, *) {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: orientation))
        } else {
            UIDevice.current.setValue(orientation.toUIInterfaceOrientation.rawValue, forKey: "orientation")
        }
    }
}

extension UIInterfaceOrientationMask {
    var toUIInterfaceOrientation: UIInterfaceOrientation {
        switch self {
        case .portrait:
            return UIInterfaceOrientation.portrait
        case .portraitUpsideDown:
            return UIInterfaceOrientation.portraitUpsideDown
        case .landscapeRight:
            return UIInterfaceOrientation.landscapeRight
        case .landscapeLeft:
            return UIInterfaceOrientation.landscapeLeft
        default:
            return UIInterfaceOrientation.unknown
        }
    }
}
