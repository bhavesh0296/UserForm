//
//  FormViewController.swift
//  UserProfile
//
//  Created by Daffodilmac-10 on 23/07/18.
//  Copyright © 2018 Daffodilmac-10. All rights reserved.
//

import UIKit
import CoreData

class FormViewController: UIViewController {
    
    var user : User = User()
    var isFormFilled: Bool = false
    //var userId : Int = 2500
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var buttonForm: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("--form sview view did load is called --")
        print(user.name, user.userId)
        if isFormFilled {
            isFormFilled = !isFormFilled
            preFilledForm()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func preFilledForm(){
        print("prefilled Form Method is called")
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        request.predicate = NSPredicate(format: "userId = %@", user.userId)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                nameField.text = data.value(forKey: "name") as? String
                phoneField.text = data.value(forKey: "phone") as? String
                addressField.text = data.value(forKey: "address") as? String
                emailField.text = data.value(forKey: "email") as? String
                print(data.value(forKey: "name") as! String)
            }
        } catch {
            print("Failed")
            
        }
    }
   
   
    @IBAction func buttonFormClicked(_ sender: Any) {
        print("form button clicked")
        let userDetail = UserDetail()
        userDetail.name = nameField.text!
        userDetail.address  = addressField.text
        userDetail.email = emailField.text
        userDetail.phone = phoneField.text
        var result = false
        print(">>>",user.userId,"<<<")
        if  user.userId == ""{
            print("save method is called")
            userDetail.userId = generateRandomDigits(6)
            print(userDetail)
            result = saveUserDetail(userDetail: userDetail)
        }else{
            print("update method is called")
            userDetail.userId = user.userId
            result = updateUserDetail(userDetail: userDetail)
        }
        
        
        if result {
            print("user added")
           
        }else{
            print("user additin failed")
        }
        navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    func generateRandomDigits(_ digitNumber: Int) -> String {
        var number = ""
        for i in 0..<digitNumber {
            var randomNumber = arc4random_uniform(10)
            while randomNumber == 0 && i == 0 {
                randomNumber = arc4random_uniform(10)
            }
            number += "\(randomNumber)"
        }
        return number
    }
    
    
    
    
    //DB Management methods
    func saveUserDetail( userDetail : UserDetail)-> Bool{
        print("--save userdetail method is called--")
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Profile", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(userDetail.name, forKey: "name")
        newUser.setValue(userDetail.userId, forKey: "userId")
        newUser.setValue(userDetail.address, forKey: "address")
        newUser.setValue(userDetail.email, forKey: "email")
        newUser.setValue(userDetail.phone, forKey:"phone")
        do {
            try context.save()
            return true
        } catch {
            print("Failed saving")
            return false
        }
    }
    
    func updateUserDetail(userDetail:UserDetail)->Bool{
        print("--update userDetail method is called--")
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        request.predicate = NSPredicate(format: "userId = %@", user.userId)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                data.setValue(userDetail.name, forKey: "name")
                data.setValue(userDetail.phone, forKey:"phone")
                data.setValue(userDetail.address, forKey: "address")
                data.setValue(userDetail.email, forKey: "email")
                print(data.value(forKey: "name") as! String)
            }
            try context.save()
            return true
         }catch {
            print("Failed saving")
            return false
        }
       
    }
    
    
    


}
