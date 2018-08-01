//
//  FormViewController.swift
//  UserProfile
//
//  Created by Daffodilmac-10 on 23/07/18.
//  Copyright © 2018 Daffodilmac-10. All rights reserved.
//


import UIKit
import DLRadioButton

class FormViewController: UIViewController{
    
   

    var datePicker: UIDatePicker! = UIDatePicker()
    var user: UserDetail?
    var formViewPresenter : FormViewPresenter!
   
    
    @IBOutlet weak var maleBtn: DLRadioButton!
    @IBOutlet weak var femaleBtn: DLRadioButton!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("----form view view did load is called --")
        dobField.inputView=datePicker
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(FormViewController.getSelectedDate), for: UIControlEvents.valueChanged)
        formViewPresenter = FormViewPresenter(delegate:self)
        formViewPresenter?.prefilled(user:user)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
   
    @IBAction func submitButtonClicked(_ sender: Any) {
        let user = formViewPresenter?.getUser(name:nameField.text, address:addressField.text, userId:self.user?.userId)
        print(formViewPresenter)
        formViewPresenter?.addUser(userDetail: user!)
        print("submit action performed")
    }
    
    @objc func getSelectedDate(sender:UIDatePicker){
        let dateFormet = DateFormatter()
        dateFormet.dateStyle = DateFormatter.Style.full
        dateFormet.timeStyle = DateFormatter.Style.none
        dobField.text = dateFormet.string(from: (sender.date))
    }
   
}

extension FormViewController : FormViewDelegate{
    
    func success() {
        print("--Success---")
        navigationController?.popToRootViewController(animated: true)
    }
    
    func failed(message: String) {
        print("--failed--")
    }
    
    func prefilledUserDetail(){
        print("prefilled Form Method is called")
        nameField.text = userDetailArray[(user?.userId)!].name
        phoneField.text = userDetailArray[(user?.userId)!].phone
        addressField.text = userDetailArray[(user?.userId)!].address
        emailField.text = userDetailArray[(user?.userId)!].email
        dobField.text = userDetailArray[(user?.userId)!].dob
//        if userDetailArray[(user?.userId)!].gender == "male" {
//            maleBtn.sendActions(for: .touchUpInside)
//            print("male action")
//        }else if userDetailArray[(user?.userId)!].gender == "female"{
//            femaleBtn.sendActions(for: .touchUpInside)
//            print("femlae action")
//        }
    }
}
