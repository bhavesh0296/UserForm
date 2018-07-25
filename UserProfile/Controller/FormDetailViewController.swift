//
//  FormDetailViewController.swift
//  UserProfile
//
//  Created by Daffodilmac-10 on 23/07/18.
//  Copyright © 2018 Daffodilmac-10. All rights reserved.
//

import UIKit
import CoreData

class FormDetailViewController: UIViewController {
    
    var user : User = User()
    var isView : Bool!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var dobLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
         print("--view segue called", user.name, " ---")
        print(user.name, user.userId)
        
        if isView {
            isView = !isView
            filledDetails()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filledDetails(){
        print("--filled details method is called--")
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        request.predicate = NSPredicate(format: "userId = %@", user.userId)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                nameLabel.text = data.value(forKey: "name") as? String
                phoneLabel.text = data.value(forKey: "phone") as? String
                addressLabel.text = data.value(forKey: "address") as? String
                emailLabel.text = data.value(forKey: "email") as? String
                genderLabel.text = data.value(forKey: "gender") as? String
                dobLabel.text = data.value(forKey: "dob") as? String
                print(data.value(forKey: "name") as! String)
            }
        } catch {
            print("Failed")
            
        }
        
    }
    

    

}
