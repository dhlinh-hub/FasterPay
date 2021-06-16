//
//  LoginViewController.swift
//  SampleApp
//
//  Created by Ishipo on 07/06/2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var topLogo: UIImageView!
    @IBOutlet weak var verticalLable: UILabel!
    @IBOutlet weak var topLogin: UILabel!
    @IBOutlet weak var useLabel: UILabel!
    @IBOutlet weak var passWordLogo: UIButton!
    @IBOutlet weak var accoutLable: UILabel!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    let touchID : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "touchid")
        image.tintColor = UIColor.black
        
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //user is already logged in just navigate him to home screen
        
        
        setupCongfig()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        EmailTextField.text = ""
        passwordTextField.text = ""
    }
    
    
    func setupCongfig() {
        EmailTextField.layer.opacity = 0.3
        passwordTextField.layer.opacity = 0.3
        loginButton.layer.cornerRadius = 15
        signupButton.layer.cornerRadius = 15
        
        
        //touchID
        
        passwordTextField.addSubview(touchID)
        touchID.heightAnchor.constraint(equalToConstant: 32).isActive = true
        touchID.widthAnchor.constraint(equalToConstant: 32).isActive = true
        touchID.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -5).isActive = true
        touchID.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 10).isActive = true
    }
    
    private func saveUserName(email: String?) {
        UserDefaults.standard.setValue(email, forKeyPath: "save_username")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        guard  let email = EmailTextField.text , let password = passwordTextField.text else {return}
        
        FireBaseAuthManager.shared.Login(email, password, completion: { (status) in
            if status {
                
                let vc = Globals.setupTabar()
                vc.modalPresentationStyle  = .fullScreen
                self.present(vc, animated: false, completion: nil)
                //                self.saveUserName(email: email)
            } else {
                let arlet = UIAlertController(title: "Incorrect account or password", message: "", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                
                arlet.addAction(cancel)
                self.present(arlet, animated: true, completion: nil)
                
                print("Đăng nhập không thành công")
            }
        })
    }
    
    
    @IBAction func onSignUp(_ sender: Any) {
        
        let vc = RegisterViewController()
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
        
    }
    
    
}
