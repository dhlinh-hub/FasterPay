//
//  PayInViewController.swift
//  SampleApp
//
//  Created by Ishipo on 16/06/2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class PayInViewController: UIViewController {
    
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var payInButton: UIButton!
    @IBOutlet weak var statusMoneyLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var moneyNow : Int?
    var total : Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMoney()
    }
    
    @IBAction func onBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPayIn(_ sender: Any) {
        
        
        
        guard let money = Int(moneyTextField.text!) else {return}
        total = Float(moneyNow ?? 0) + Float(money)
        
        
        let arlet = UIAlertController(title: "Report", message: "Pay in success", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: { act in
            guard let uid = Auth.auth().currentUser?.uid else {return}
            let ref = Database.database().reference()
            ref.child("user").child(uid).child("money").setValue(self.total)
            
        })
        
        arlet.addAction(ok)
        self.present(arlet, animated: true, completion: nil)
        
    }
    
    
    private func fetchMoney() {
        
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("user").child(uid!).observe(.value, with: {(snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                if let money = dictionary["money"] as? Int {
                    self.saveMoney(money)
                }
                
                
            }
            
        })
        
    }
    
    func saveMoney( _ money : Int) {
        moneyNow = money
        self.statusMoneyLabel.text = "The amount of money in the account: $\(money)"
    }
    
    
}


