//
//  PayMentViewController.swift
//  SampleApp
//
//  Created by Ishipo on 07/06/2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Kingfisher

class PayMentViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var itemLogo: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPlace: UILabel!
    
    @IBOutlet weak var moneyPay: UILabel!
    @IBOutlet weak var moneyWallet: UILabel!
    @IBOutlet weak var Payment: UIButton!
    @IBOutlet weak var botView: UIView!
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    private var _order: Order?
    var moneyP : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupconfig()
        fetchMoney()
        
    }
    
    public func setData(_ order: Order) {
        _order = order
        updateUI(with: order)
        
    }
    
    private func updateUI(with order: Order) {
        if order.image != "" {
            let url = URL(string: order.image ?? "")
            itemLogo.kf.setImage(with: url)
        }else {
            itemLogo.image = UIImage(named: "pubg")
            
        }
        itemName.text = order.title ?? ""
        itemPlace.text = order.message ?? ""
        moneyPay.text = "\(order.amount ?? 0)"
        Payment.setTitle("Pay $ \(order.amount ?? 0)", for: .normal)
    }
    
    public func saveItem(_ order: Order) {
        
        let userData = ["title": order.title ?? "" ,
                        "message": order.message ?? "" ,
                        "amount": order.amount ?? 0,
                        "image" : order.image ?? ""
        ] as [String : Any]
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("user").child(uid!).observeSingleEvent(of: .value) { listData in
            guard let dic = listData.value as? [String: Any] else { return }
            if let listObj = dic["List"] as? [String: Any] {
                Database.database().reference().child("user").child(uid!).child("List").child("item\(listObj.count)").setValue(userData)
            } else {
                Database.database().reference().child("user").child(uid!).child("List").child("item\(0)").setValue(userData)
            }
        }
    }
    
    private func setupconfig() {
        Payment.layer.cornerRadius = 15
        botView.layer.cornerRadius = 35
        botView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner  ]
        itemView.layer.cornerRadius = 35
        itemView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner  ]
        itemLogo.layer.cornerRadius = 50
        
        backButton.tintColor = UIColor.white
        backButton.addTarget(self, action: #selector(onback), for:.touchUpInside)
        
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
    func saveMoney(_ sender: Int ) {
        moneyP = sender
        self.moneyWallet.text = "\(sender)"
        
        
    }
    
    @IBAction func onPayment(_ sender: Any) {
        guard let o = _order else {
            return
        }
        setupAlert(order: o)
    }
    
    @objc func onback() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupAlert(order : Order) {
        
        let arlet = UIAlertController(title: "Report", message: "Are you sure with your decision?", preferredStyle: .alert)
        let yesBT = UIAlertAction(title: "Yes", style: .default, handler: {(action) in
            if order.amount ?? 0 <= self.moneyP ?? 0 {
                self.saveItem(order)
                let toTal: Float = Float(self.moneyP ?? 0 ) - Float(order.amount ?? 0)
                
                let vc = CongratulationViewController()
                vc.toTall = toTal
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                
            }else {
                
                let arlet = UIAlertController(title: "Not enough money", message: "Do you want to add more money to your account?", preferredStyle: .alert)
                
                let no = UIAlertAction(title: "No", style: .cancel, handler: nil)
                let yes = UIAlertAction(title: "Yes", style: .default, handler: { action in
                    
                    let vc  = PayInViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: false, completion: {
                    })
                })
                arlet.addAction(no)
                arlet.addAction(yes)
                self.present(arlet, animated: true, completion: nil)
            }
        })
        
        let noBT = UIAlertAction(title: "No", style: .cancel, handler: nil)
        arlet.addAction(yesBT)
        arlet.addAction(noBT)
        self.present(arlet, animated: true, completion: nil)
    }
}
