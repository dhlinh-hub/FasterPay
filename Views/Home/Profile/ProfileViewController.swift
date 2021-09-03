//
//  ProfileViewController.swift
//  SampleApp
//
//  Created by Ishipo on 07/06/2021.
//

import UIKit
import  FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var phoneNumber: UILabel!
    
    var data = [Profile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        data = updateProfile()
        
        tableView.register(UINib(nibName: "Profile", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        setupconfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUser()
    }
    
    func setupconfig() {
        tableView.layer.cornerRadius = 40
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner  ]
        
    }
    
    
    private func fetchUser() {
        
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("user").child(uid!).observe(.value, with: {(snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                self.nameLabel.text = dictionary["fullName"] as? String
                self.phoneNumber.text = dictionary["phonenumber"] as? String
            }
            
        })
        
    }
    
}


extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        
        
        cell.imageIcon.image = UIImage(named: data[indexPath.row].image ?? "")
        cell.discriptionLbl.text = data[indexPath.row].title
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let size = tableView.frame.height
        
        return CGFloat(size/7.2)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProfileTableViewCell
        
        cell.contentView.layer.opacity = 0.5
        print("tapped")
        
        if (data[indexPath.row].title == "LogOut") {
            FireBaseAuthManager.shared.Logout { (status) in
                if status {
                    self.goBackLoginScreen()
                } else {
                    print("Đăng xuất không thành công")
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProfileTableViewCell
        cell.contentView.layer.opacity = 1
        
    }
    
    func goBackLoginScreen() {
        let loginVC = LoginViewController()
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = loginVC
            window.makeKeyAndVisible()
        }
        
        
    }
    
}
