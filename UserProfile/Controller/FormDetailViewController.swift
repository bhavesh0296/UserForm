//
//  FormDetailViewController.swift
//  UserProfile
//
//  Created by Daffodilmac-10 on 23/07/18.
//  Copyright © 2018 Daffodilmac-10. All rights reserved.
//

import UIKit

class FormDetailViewController: UIViewController {
    
    var user : User = User()
    var isView : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print("view segue called", user.name, " ----")
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
        print("filled details method is called")
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
