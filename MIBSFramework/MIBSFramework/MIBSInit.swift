//
//  MIBSInit.swift
//  MIBSSDK
//
//  Created by Maulik Vora on 08/07/22.
//

import Foundation
import UIKit
//var appDelegate = UIApplication()
var uvGloab:UIViewController!
@objc public class MIBSInit: NSObject {
    let hello = "Hello"
    @objc public var uv:UIViewController!
    
    @objc public init(uv:UIViewController) {
        self.uv = uv
        uvGloab = uv
    }
    
    @objc public func hello(to whom: String) -> String {
        return "Hello \(whom)"
    }
    
    @objc public func loadData(){
//        do {
//            try fontsURLs().forEach({ try UIFont.register(from: $0) })
//        } catch {
//            print(error)
//        }
        UIFont.jbs_registerFont(
            withFilenameString: "Gotham-Medium.ttf",
            bundle: bundleIdentifireGlob!
        )
        UIFont.jbs_registerFont(
            withFilenameString: "Gotham-Book.ttf",
            bundle: bundleIdentifireGlob!
        )
        
        print("...Start Opening SDK...**** 1.0")
        //--
        let frameworkBundle = Bundle(for: type(of: self))
        let storyboard = UIStoryboard(name: "Main", bundle: frameworkBundle)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        //let vc = LivenessCheckVC(nibName: "LivenessCheckVC", bundle: Bundle(identifier: "com.CSETesterApp.MIBSFramework"))
        uvGloab.navigationController?.pushViewController(vc, animated: true)
        /*
        let nav = UINavigationController(rootViewController: vc)
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        */
        //uv.navigationController!.pushViewController(vc, animated: true)
        //uv.present(vc, animated: true, completion: nil)
        
        /*let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: frameworkBundle)
         let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "FirstVC") as! FirstVC
         //appDelegate.keyWindow = UIWindow(frame: UIScreen.main.bounds)
         UIApplication().keyWindow?.rootViewController = initialViewControlleripad
         UIApplication().keyWindow?.makeKeyAndVisible()*/
        //        let vcs = FirstVC()
        //        vcs.loadSecondVC()
        
    }
}
extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
        // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
        // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
        // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
        // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}
func fontsURLs() -> [URL] {
    if let bundle =  bundleIdentifireGlob{
        let fileNames = ["Gotham-Book", "Gotham-Medium"]
        return fileNames.map({ bundle.url(forResource: $0, withExtension: "ttf")! })
    }
    return []
}

public extension UIFont {

    static func jbs_registerFont(withFilenameString filenameString: String, bundle: Bundle) {

        guard let pathForResourceString = bundle.path(forResource: filenameString, ofType: nil) else {
            print("UIFont+:  Failed to register font - path for resource not found.")
            return
        }

        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            print("UIFont+:  Failed to register font - font data could not be loaded.")
            return
        }

        guard let dataProvider = CGDataProvider(data: fontData) else {
            print("UIFont+:  Failed to register font - data provider could not be loaded.")
            return
        }

        guard let font = CGFont(dataProvider) else {
            print("UIFont+:  Failed to register font - font could not be loaded.")
            return
        }

        var errorRef: Unmanaged<CFError>? = nil
        if (CTFontManagerRegisterGraphicsFont(font, &errorRef) == false) {
            print("UIFont+:  Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }

}


//MARK: - Common Veriable
let bundleIdentifireGlob = Bundle(identifier: "com.simplecrm.ekyc.MIBSFramework") //"com.CSETesterApp.MIBSFramework")
