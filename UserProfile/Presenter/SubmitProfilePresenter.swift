//
//  SubmitProfilePresenter.swift
//  UserProfile
//
//  Created by Daffodilmac-10 on 27/07/18.
//  Copyright © 2018 Daffodilmac-10. All rights reserved.
//

import Foundation

class SubmitProfilePresenter {
    
    func submitProfile(user: UserDetail){
        var appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.UserDetailArr.append(user)
    }
}

