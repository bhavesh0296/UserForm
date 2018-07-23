//
//  FormViewController.swift
//  UserProfile
//
//  Created by Daffodilmac-10 on 23/07/18.
//  Copyright © 2018 Daffodilmac-10. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    
    var user : User = User()
    var isFormFilled: Bool = false
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var buttonForm: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("form segue called")
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
    }
   
   
    @IBAction func buttonFormClicked(_ sender: Any) {
        print("form button clicked")
        var userDetail = UserDetail()
        userDetail.name = nameField.text!
        userDetail.address  = addressField.text
        userDetail.email = emailField.text
        userDetail.phone = phoneField.text
        print(userDetail)
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
