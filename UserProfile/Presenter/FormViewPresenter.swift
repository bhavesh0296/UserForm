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
    func popImagePicker()
    func setUserImage(chosenImage : UIImage?)
}


//import Foundation
import UIKit
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
    
    func getUser(name:String?, address:String?, userId : Int? , userImage : UIImage?)->UserDetail{
        let user = UserDetail()
        user.name = name
        user.address = address
        user.userId = userId
        user.userImage = userImage
        return user
    }
    
    func showImagePicker(){
        delegate?.popImagePicker()
    }
    
    func userImage(chosenImage: UIImage?){
        delegate?.setUserImage(chosenImage: chosenImage)
    }
    
}
