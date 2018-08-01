//
//  TableViewCell.swift
//  UserProfile
//
//  Created by Daffodilmac-10 on 23/07/18.
//  Copyright © 2018 Daffodilmac-10. All rights reserved.
//

import UIKit

protocol NavigationEditViewDelegate :class {
    func editNavigation(user: UserDetail)
    func viewNavigation(user: UserDetail)
}

class TableViewCell: UITableViewCell {

    
    var delegate : NavigationEditViewDelegate?
    
    @IBOutlet weak var cellLabel: UILabel!
    
    var userId : Int?  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func editAction(_ sender: Any) {
        print("Edit Action", userId!)
        if(self.delegate != nil){
            self.delegate?.editNavigation(user : getUser())
        }
        
    }
    
    @IBAction func viewAction(_ sender: Any) {
        print("View Action", userId!)
            self.delegate?.viewNavigation(user : getUser())
        
    }
    
    func getUser() -> UserDetail {
        var user = UserDetail();
        user.name = cellLabel.text!
        user.userId = userId
        return user
    }
}
