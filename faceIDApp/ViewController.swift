//
//  ViewController.swift
//  faceIDApp
//
//  Created by asmaa gamal  on 20/01/2024.
//

import UIKit
import LocalAuthentication   // first import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))    //2nd create the button
        button.center = view.center
        button.setTitle("Autherize", for: .normal)
        button.backgroundColor = .systemOrange
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(button)   // add the button to the view
    }
    @objc func didTapButton(){
        let context = LAContext() //is used for evaluating the user's biometric identity (fingerprint or face) and checking device passcode.
        var error : NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){ // : It allows you to request authentication using the biometric features available on the device, such as Touch ID (fingerprint) or Face ID.
            let reason = "please autherize with face id"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self]success, error in
                DispatchQueue.main.async{
                    guard success , error == nil else {
                        let alert = UIAlertController(
                            title: "Faild to Authorize"
                            , message: "please try again "
                            , preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "cancel", style: .cancel , handler: nil))
                        self?.present(alert,animated:true)
                        
                        return
                    }
                }
                DispatchQueue.main.async{
                    let viewController = UIViewController()
                    viewController.title = "welcome"
                    viewController.view.backgroundColor = .systemBlue
                    self?.present(UINavigationController(rootViewController: viewController),animated: true , completion:  nil)
                    
                }
            }
            
        }else{
            DispatchQueue.main.async{
                let alert = UIAlertController(
                    title: "Faild to Authorize"
                    , message: "please try again "
                    , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "cancel", style: .cancel , handler: nil))
                self.present(alert,animated:true)
                
                return
            }
        }
    }

}

