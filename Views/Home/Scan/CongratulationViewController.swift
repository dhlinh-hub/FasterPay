//
//  CongratulationViewController.swift
//  SampleApp
//
//  Created by Ishipo on 15/06/2021.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class CongratulationViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
   
    var toTall : Float?
    override func viewDidLoad() {
        super.viewDidLoad()
        moneyLabel.text = "$ \(toTall ?? 0)"
        
        
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("user").child(uid!).child("money").setValue(toTall)
        
    }
    
    
    @IBAction func onBack(_ sender: Any) {
        
        let vc = Globals.setupTabar()
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: {
        })
    }
    
    @IBAction func addMoney(_ sender: Any) {
    }
    
}
