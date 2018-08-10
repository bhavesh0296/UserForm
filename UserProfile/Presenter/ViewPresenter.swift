
protocol ViewControllerDelegate:class {
    func goToEdit(user : UserDetail?)
    func gotoView(user : UserDetail)
}

import Foundation
import UIKit

class ViewPresenter {
    
    weak var delegate : ViewControllerDelegate?
    
    init(delegate: ViewControllerDelegate) {
        self.delegate = delegate
    }
    
    func moveToEdit(user : UserDetail?){
        delegate?.goToEdit(user: user)
    }
    
    func moveToView(user : UserDetail){
        delegate?.gotoView(user: user)
    }
    
    //function to delete row from table with image
    func deleteRow(at index:Int){
        let imageManager = ImageManager()
        imageManager.deleteImage(fileName: userDetailArray[index].image!)
        userDetailArray.remove(at: index)
        UserDefaults.standard.encode(for:userDetailArray, using: "userProfile")
//        delegate
    }
    
    //return user image
    func getuserImage(fileName: String)->UIImage?{
        let imageManager = ImageManager()
        return imageManager.getImage(fileName: fileName)
    }
    
    //Return array of UserDetail 
    func getData()->[UserDetail]?{
        let userDetailArr = UserDefaults.standard.decode(for: [UserDetail].self, using: "userProfile")
        if userDetailArr != nil{
            return userDetailArr
        }else{
            return [UserDetail]()
        }       
    }
}
