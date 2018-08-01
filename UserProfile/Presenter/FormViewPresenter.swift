//
//  SubmitUserPresenter.swift
//  UserProfile
//
//  Created by Daffodilmac-10 on 27/07/18.
//  Copyright © 2018 Daffodilmac-10. All rights reserved.
//


protocol FormViewDelegate:class {
    func success()
    func failed (message:String)
    func prefilledUserDetail()
}


import Foundation
class FormViewPresenter{
    
   weak var delegate : FormViewDelegate?
    
    init(delegate: FormViewDelegate){
        self.delegate = delegate
    }
    func addUser(userDetail: UserDetail){
        print("this method is called")
        if checkValidation(user: userDetail){
            if userDetail.userId != nil {
                userDetailArray[userDetail.userId] = userDetail
            }else{
                userDetailArray.append(userDetail)
            }
            delegate?.success()
        }else{
            delegate?.failed(message: "fields cant be empty")
        }
    }
    
    func checkValidation(user:UserDetail)->Bool{
        if user.address.isEmpty || user.name.isEmpty {
            return false
        }
        return true
    }
    
    func prefilled(user:UserDetail?){
        if user != nil {
            delegate?.prefilledUserDetail()
        }
    }
    
    func getUser(name:String?, address:String?, userId : Int?)->UserDetail{
        let user = UserDetail()
        user.name = name
        user.address = address
        user.userId = userId
        return user
    }
    
}
