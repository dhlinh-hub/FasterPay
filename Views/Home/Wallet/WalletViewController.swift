//
//  WalletViewController.swift
//  SampleApp
//
//  Created by Ishipo on 07/06/2021.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class WalletViewController: UIViewController {
    
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var homewalletButton: UIImageView!
    @IBOutlet weak var vaultButton: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var data = [Order]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: "WalletTableViewCell", bundle: nil), forCellReuseIdentifier: "WalletTableViewCell")
        setupconfig()
        fetchUser()
        fetchMoney()
    }
    
   
   
    
    private func fetchUser() {
        
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("user").child(uid!).observe(.value, with: {(snapshot) in
            self.data.removeAll()
            if let dictionary = snapshot.value as? [String : AnyObject] {
                if let listObj = dictionary["List"] as? [String: Any] {
                    for i in 0..<listObj.count {
                        if let data = listObj["item\(i)"] as? [String : Any] {
                            let amount = data["amount"] as? Int
                            let title = data["title"] as? String
                            let message = data["message"] as? String
                            let image = data["image"] as? String
                            let order = Order(amount: amount, title: title, message: message, image: image)
                            self.data.append(order)
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            
        })
        
    }
    
    
    
    
    private func setupconfig() {
        
        tableView.layer.cornerRadius = 40
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner  ]

    }

    private func fetchMoney() {
        
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("user").child(uid!).observe(.value, with: {(snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                if let money = dictionary["money"] as? Int {
                    self.moneyLabel.text = "\(money)"
                }
                
                
            }
            
        })
        
    }
    

    
}


extension WalletViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletTableViewCell", for: indexPath) as! WalletTableViewCell
        cell.dataOder = self.data[indexPath.row]
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            let delete = UIAlertController(title: "Are you sure you want to delete?", message: "You will not be able to review the content of this chat", preferredStyle: .alert)
            
            delete.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
                delete.dismiss(animated: true, completion: nil)
                
            }))
            
            delete.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [self] (action: UIAlertAction!) in
                self.data.remove(at: indexPath.row)
                print("\(indexPath.row)")
                tableView.deleteRows(at: [indexPath], with: .fade)
                
//                let uid = Auth.auth().currentUser?.uid
//                Database.database().reference().child("user").child(uid!).child("List").child("item\(indexPath.row)").removeValue()
            }))
            
            self.present(delete, animated: true, completion: nil)

        }
        delete.backgroundColor = .red
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
    
}
