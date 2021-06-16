//
//  RegisterViewController.swift
//  SampleApp
//
//  Created by Ishipo on 07/06/2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var PassLogo: UIImageView!
    @IBOutlet weak var CreateLabel: UILabel!
    @IBOutlet weak var touseLabel: UILabel!
    @IBOutlet weak var fastPayLogo: UIImageView!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var conditionPass1: UILabel!
    @IBOutlet weak var conditionPass2: UILabel!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var FristNameTextField: UITextField!
    @IBOutlet weak var SwichStatus: UISwitch!
    @IBOutlet weak var Agree1: UILabel!
    @IBOutlet weak var UserAgrementButton: UIButton!
    @IBOutlet weak var endLable: UILabel!
    @IBOutlet weak var ProvacyButton: UIButton!
    @IBOutlet weak var Agree2: UILabel!
    @IBOutlet weak var Agree3: UILabel!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EmailTextField.addTarget(self, action: #selector(textFieldDidChangeSelection(_:)), for: .editingChanged)
        PasswordTextField.addTarget(self, action: #selector(textFieldDidChangeSelection(_:)), for: .editingChanged)
        
        SignUpButton.layer.cornerRadius = 15
        LoginButton.layer.cornerRadius = 15
        SignUpButton.layer.opacity = 0.5
        SignUpButton.isEnabled = false
        
        
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPass(passWord : String) -> Bool {
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        let passPred = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        
        
        return passPred.evaluate(with: passWord)
    }
    
    
    @IBAction func onSignUp(_ sender: Any) {
        guard let email = EmailTextField.text, let password = PasswordTextField.text , let phone = phoneNumberTextField.text, let name = LastNameTextField.text , SwichStatus.isOn
        
        else { return }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {(userResult, error) in
            if let user = userResult?.user {
                let userData = ["phonenumber":phone ,
                                "fullName": name,
                                "email": email,
                                "money" : 100
                                
                ] as [String : Any]
                let ref = Database.database().reference()
                let userRef = ref.child("user").child(user.uid)
                userRef.setValue(userData)
                
                // arlet
                let arlet = UIAlertController(title: "Account successfully created", message: "", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "OK", style: .default, handler: {(act) in
                    self .dismiss(animated: true, completion: nil)
                })
                
                arlet.addAction(cancel)
                self.present(arlet, animated: true, completion: nil)
                
                print("tao tai khoan thanh cong")
                
            }else{
                let arlet = UIAlertController(title: "This email is already in use by someone else", message: "", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                
                arlet.addAction(cancel)
                self.present(arlet, animated: true, completion: nil)
                print(" Create account Failure")
                
            }
        })
        
        
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension RegisterViewController : UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if isValidEmail(email: EmailTextField.text!) && isValidPass(passWord: PasswordTextField.text!) {
            SignUpButton.layer.opacity = 1
            SignUpButton.isEnabled = true
        }else{
            SignUpButton.layer.opacity = 0.5
            SignUpButton.isEnabled = false
        }
    }
    
}
