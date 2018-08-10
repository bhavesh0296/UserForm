protocol FormViewDelegate:class {
    func success()
    func failed (message:String)
    func prefilledUserDetail()
    func popImagePicker()
    func setUserImage(chosenImage : UIImage?)
    func showUserImageAlertWithDelete()
    func showUserImageAlertWithoutDelete()
    func deleteUserImageConfirm()
}

import UIKit
class FormViewPresenter{
    
    weak var delegate : FormViewDelegate?
    var imageManager  : ImageManager?
    var isAddUser = true
    
    init(delegate: FormViewDelegate){
        self.delegate = delegate
        imageManager = ImageManager()
    }
    
    //Take Decision of Prefilled details in the form view
    func prefilled(user:UserDetail?){
        if user != nil {
            isAddUser = false
            delegate?.prefilledUserDetail()
        }
    }
    
    //MARK:-Return the userDetail Object
    func getUser(name:String?, address:String?, userId : Int?, phone : String?, dob : String? , email : String?, gender : String? , image : String?)->UserDetail{
        let user = UserDetail()
        user.name = name
        user.address = address
        user.userId = userId
        user.image = image
        user.phone = phone
        user.dob = dob
        user.email = email
        user.gender = gender
        return user
    }
    
    //Check Validation of User
    func checkValidation(user:UserDetail)->Bool{
        if user.address.isEmpty || user.name.isEmpty || user.phone.isEmpty || user.email.isEmpty || user.dob.isEmpty{
            return false
        }
        return true
    }
    
    //Add the user to the UserDetailArray
    func addUser(userDetail: UserDetail){
        print("this method is called")
        if checkValidation(user: userDetail){
            if userDetail.userId != nil {
                userDetailArray[userDetail.userId] = userDetail
            }else{
                userDetailArray.append(userDetail)
            }
            UserDefaults.standard.encode(for:userDetailArray, using: "userProfile")
            delegate?.success()
        }else{
            delegate?.failed(message: "fields cant be empty")
        }
    }
    
    //Add the user to the UserDetailArray
    func addUser(userDetail: UserDetail, preUser: UserDetail){
        print("this method is called")
        if checkValidation(user: userDetail){
            if isAddUser {
                userDetailArray.append(userDetail)
            }else{
                preUser.name = userDetail.name
                preUser.email = userDetail.email
                preUser.dob = userDetail.dob
                preUser.gender = userDetail.gender
                preUser.image = userDetail.image
                preUser.phone = userDetail.phone
            }
            UserDefaults.standard.encode(for:userDetailArray, using: "userProfile")
            delegate?.success()
        }else{
            delegate?.failed(message: "fields cant be empty")
        }
    }
    
    
    
    
    
    //take decision of which image alert to show
    func userImageButtonPerformed(isUserDefaultImage: Bool){
        if isUserDefaultImage {
            delegate?.showUserImageAlertWithDelete()
        }else{
            delegate?.showUserImageAlertWithoutDelete()
        }
    }
    
    //decision to show image picker
    func showImagePicker(){
        print("presenter image picker method is called")
        delegate?.popImagePicker()
    }
    
    //take decision to set user image on image view on the form view
    func userImage(chosenImage: UIImage ){
        delegate?.setUserImage(chosenImage: chosenImage)
    }
    
    //Save User image to document directory
    func saveUserImage(chosenImage: UIImage?, imageName: String)->String{
        return (imageManager?.saveImage(chosenImage:chosenImage, imageName: imageName))!
    }
        
    //Return UIImage object of user Image
    func getUserImage(fileName : String)-> UIImage?{
        return imageManager?.getImage(fileName:fileName)
    }
    
    //Delete user image
    func deleteUserImage(fileName : String){
        imageManager?.deleteImage(fileName: fileName)
        
        delegate?.deleteUserImageConfirm()
    }
}


