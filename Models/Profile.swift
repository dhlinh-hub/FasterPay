//
//  Modals.swift
//  SampleApp
//
//  Created by Ishipo on 08/06/2021.
//



struct Profile {
    var image : String?
    var title : String?
}


func updateProfile() -> [Profile] {
    let s1 = Profile(image: "p1", title: "Notifications")
    let s2 = Profile(image: "p2", title: "Personal Infomation")
    let s3 = Profile(image: "p3", title: "Sercurity Settings")
    let s4 = Profile(image: "p4", title: "Helps & Support")
    let s5 = Profile(image: "p5", title: "Terms of use")
    let s6 = Profile(image: "p6", title: "LogOut")
    
    
    return [s1 ,s2 , s3, s4, s5 , s6]
}
