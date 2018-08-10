
import UIKit
import DLRadioButton
import Photos

class FormViewController: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    var datePicker = UIDatePicker()
    var imagePicker = UIImagePickerController()
    var user: UserDetail?
    var formViewPresenter : FormViewPresenter!
    var chosenImage : UIImage?
    var isUserDefaultImage = false
   
    @IBOutlet weak var maleBtn: DLRadioButton!
    @IBOutlet weak var femaleBtn: DLRadioButton!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var userImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup(){
        pickUpDate(self.dobField)
        formViewPresenter = FormViewPresenter(delegate:self)
        formViewPresenter?.prefilled(user:user)
        imagePicker.delegate = self
    }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        let fileName = formViewPresenter.saveUserImage(chosenImage: chosenImage, imageName: nameField.text!)
        let user = formViewPresenter?.getUser(name:nameField.text, address:addressField.text, userId:self.user?.userId, phone: phoneField.text, dob: dobField.text, email: emailField.text, gender: "male" ,image: fileName)
        print(formViewPresenter)
        
        formViewPresenter?.addUser(userDetail: user!, preUser : self.user!)
        print("submit action performed")
    }
   
    @IBAction func userImageButtonAction(_ sender: UIButton) {
        formViewPresenter.userImageButtonPerformed(isUserDefaultImage: isUserDefaultImage)
    }
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        chosenImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)
        formViewPresenter.userImage(chosenImage: chosenImage!)
    }
    
    //MARK:- Function of datePicker
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePickerMode.date
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(FormViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(FormViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    // MARK:- Button Done and Cancel
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        dobField.text = dateFormatter1.string(from: datePicker.date)
        dobField.resignFirstResponder()
    }
    @objc func cancelClick() {
        dobField.resignFirstResponder()
    }
}

extension FormViewController : FormViewDelegate{
    
    func success() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func failed(message: String) {
        let alert = UIAlertController(title: "Alert", message: "Fill all the details", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func prefilledUserDetail(){
        print("prefilled Form Method is called")
        nameField.text = user?.name
        phoneField.text = user?.phone
        addressField.text = user?.address
        emailField.text = user?.email
        dobField.text = user?.dob
        chosenImage = formViewPresenter.getUserImage(fileName: (user?.image!)!)
        if chosenImage != nil {
            userImageButton.setBackgroundImage(chosenImage, for: .normal)
            isUserDefaultImage = true
        }
//        nameField.text = userDetailArray[(user?.userId)!].name
//        phoneField.text = userDetailArray[(user?.userId)!].phone
//        addressField.text = userDetailArray[(user?.userId)!].address
//        emailField.text = userDetailArray[(user?.userId)!].email
//        dobField.text = userDetailArray[(user?.userId)!].dob
//        chosenImage = formViewPresenter.getUserImage(fileName: userDetailArray[(user?.userId)!].image!)
//        if chosenImage != nil {
//            userImageButton.setBackgroundImage(chosenImage, for: .normal)
//            isUserDefaultImage = true
//        }
//        userImage.image = userDetailArray[(user?.userId)!].userImage
//        if userDetailArray[(user?.userId)!].gender == "male" {
//            maleBtn.sendActions(for: .touchUpInside)
//            print("male action")
//        }else if userDetailArray[(user?.userId)!].gender == "female"{
//            femaleBtn.sendActions(for: .touchUpInside)
//            print("femlae action")
//        }
    }
    
    func setUserImage(chosenImage : UIImage?){
//        userImage.image = chosenImage
        userImageButton.setBackgroundImage(chosenImage, for: .normal)
        isUserDefaultImage = true
        dismiss(animated: true, completion: nil)
    }
    
    func showUserImageAlertWithDelete() {
        let showImageAlert = UIAlertController(title: "Image Upload", message: "choose the option", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "camera", style: .default) { (action:UIAlertAction!) in
            print("camera button tapped");
        }
        let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default) { (action:UIAlertAction!) in
            print("photoLibrary button tapped");
            self.formViewPresenter.showImagePicker()
        }
        let deleteAction = UIAlertAction(title: "delete", style: .destructive ) { (action:UIAlertAction!) in
            print("delete button tapped");
            self.formViewPresenter.deleteUserImage(fileName: userDetailArray[(self.user?.userId)!].image!);
            self.isUserDefaultImage = true
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel ) { (action:UIAlertAction!) in
            print("cancel button tapped");
        }
        showImageAlert.addAction(cameraAction)
        showImageAlert.addAction(photoLibraryAction)
        showImageAlert.addAction(deleteAction)
        showImageAlert.addAction(cancelAction)
        self.present(showImageAlert, animated: true, completion:nil)
    }
    
    func showUserImageAlertWithoutDelete() {
        let showImageAlert = UIAlertController(title: "Image Upload", message: "choose the option", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "camera", style: .default) { (action:UIAlertAction!) in
            print("camera button tapped");
        }
        let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default) { (action:UIAlertAction!) in
            print("photoLibrary button tapped");
            self.formViewPresenter.showImagePicker()
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel ) { (action:UIAlertAction!) in
            print("cancel button tapped");
        }
        showImageAlert.addAction(cameraAction)
        showImageAlert.addAction(photoLibraryAction)
        showImageAlert.addAction(cancelAction)
        self.present(showImageAlert, animated: true, completion:nil)
    }
    
    func popImagePicker(){
        print("this method is called")
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
    }
    
    func deleteUserImageConfirm(){
        print("delete confirmation")
        userImageButton.setBackgroundImage(#imageLiteral(resourceName: "defaultUserImage"), for: .normal)
    }   
}
