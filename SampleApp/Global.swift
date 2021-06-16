//
//  Global.swift
//  SampleApp
//
//  Created by Ishipo on 11/06/2021.
//
import UIKit

class Globals {
    static func setupTabar() -> UITabBarController {
        let tabar = UITabBarController()
        
        
        
        
        let walletVC = WalletViewController()
        walletVC.tabBarItem = UITabBarItem(title: "Wallet",
                                           image: UIImage(named: "W"),
                                           selectedImage: UIImage(named: "W2")?.withRenderingMode(.alwaysOriginal))
       
      
        let scanVC = ScanViewController()
        scanVC.tabBarItem = UITabBarItem(title: "Scan", image: UIImage(named: "scan"), selectedImage: UIImage(named:"scan2")?.withRenderingMode(.alwaysOriginal))
        
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), selectedImage: UIImage(named:"profile2")?.withRenderingMode(.alwaysOriginal))
        
       
        
        tabar.setViewControllers([walletVC, scanVC, profileVC], animated: true)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 1.00, green: 0.74, blue: 0.00, alpha: 1.00)], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 1.00, green: 0.74, blue: 0.00, alpha: 1.00)], for: .normal)
        
        return tabar
    }
}
