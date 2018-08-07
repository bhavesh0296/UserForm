//
//  FormViewController.swift
//  UserProfile
//
//  Created by Daffodilmac-10 on 23/07/18.
//  Copyright © 2018 Daffodilmac-10. All rights reserved.
//


import UIKit
import DLRadioButton

class FormViewController: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
   

    var datePicker = UIDatePicker()
    var imagePicker = UIImagePickerController()
    var user: UserDetail?
    var formViewPresenter : FormViewPresenter!
    var chosenImage : UIImage?
   
    
    @IBOutlet weak var maleBtn: DLRadioButton!
    @IBOutlet weak var femaleBtn: DLRadioButton!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("----form view view did load is called --")
        dobField.inputView=datePicker
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(FormViewController.getSelectedDate), for: UIControlEvents.valueChanged)
        formViewPresenter = FormViewPresenter(delegate:self)
        formViewPresenter?.prefilled(user:user)
        imagePicker.delegate = self
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
   
    @IBAction func submitButtonClicked(_ sender: Any) {
        let user = formViewPresenter?.getUser(name:nameField.text, address:addressField.text, userId:self.user?.userId, userImage : chosenImage)
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
    
    @IBAction func selectImageAction(_ sender: UIButton) {
        formViewPresenter?.showImagePicker()
        print("this methos is called")
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        chosenImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)
        formViewPresenter.userImage(chosenImage: chosenImage)
    }
   
}

extension FormViewController : FormViewDelegate{
    
    func success() {
        print("--Success---")
        navigationController?.popToRootViewController(animated: true)
    }
    
    func failed(message: String) {
        print("--failed--")
        let alert = UIAlertController(title: "Alert", message: "Fill all the details", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func prefilledUserDetail(){
        print("prefilled Form Method is called")
        nameField.text = userDetailArray[(user?.userId)!].name
        phoneField.text = userDetailArray[(user?.userId)!].phone
        addressField.text = userDetailArray[(user?.userId)!].address
        emailField.text = userDetailArray[(user?.userId)!].email
        dobField.text = userDetailArray[(user?.userId)!].dob
        userImage.image = userDetailArray[(user?.userId)!].userImage
//        if userDetailArray[(user?.userId)!].gender == "male" {
//            maleBtn.sendActions(for: .touchUpInside)
//            print("male action")
//        }else if userDetailArray[(user?.userId)!].gender == "female"{
//            femaleBtn.sendActions(for: .touchUpInside)
//            print("femlae action")
//        }
    }
    
    func popImagePicker(){
        print("this method is called")
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
    }
    
    func setUserImage(chosenImage : UIImage?){
        userImage.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
}
