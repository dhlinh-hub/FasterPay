//
//  FireBaseAuthManager.swift
//  SampleApp
//
//  Created by Ishipo on 08/06/2021.
//

import Foundation
import  FirebaseAuth

class FireBaseAuthManager {
    static let shared = FireBaseAuthManager()
    
    func Login(_ email: String, _ password: String , completion: @escaping ((_ success: Bool) -> Void) ){
        Auth.auth().signIn(withEmail: email, password: password, completion: {(userResult, error) in
            if let error = error {
                print("\(error)")
                completion(false)
            }else {
                completion(true)
                
            }
        })
    }
    
    
    func Logout(completion: @escaping ((_ success: Bool) -> Void)){
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch let logOutError as NSError {
            print("Error: \(logOutError)")
            completion(false)
        }
    }
}



