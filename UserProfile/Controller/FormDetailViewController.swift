//
//  FormDetailViewController.swift
//  UserProfile
//
//  Created by Daffodilmac-10 on 30/07/18.
//  Copyright © 2018 Daffodilmac-10. All rights reserved.
//

import UIKit

class FormDetailViewController: UIViewController {
    
    var user: UserDetail?
    var presenter : FormDetailViewPresenter?
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = FormDetailViewPresenter(delegate: self)
        presenter?.viewDetail()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    

   
}
extension FormDetailViewController : FormDetailViewDelegate{
    func showDetail(){
        nameLabel.text = userDetailArray[(user?.userId)!].name
        genderLabel.text = userDetailArray[(user?.userId)!].gender
        phoneLabel.text = userDetailArray[(user?.userId)!].phone
        dobLabel.text = userDetailArray[(user?.userId)!].dob
        emailLabel.text = userDetailArray[(user?.userId)!].email
        addressLabel.text = userDetailArray[(user?.userId)!].address
    }
}
