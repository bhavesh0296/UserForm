//
//  TableViewCell.swift
//  UserProfile
//
//  Created by Daffodilmac-10 on 23/07/18.
//  Copyright © 2018 Daffodilmac-10. All rights reserved.
//

import UIKit

protocol segueEditView {
    func editSegue(user dataobject: AnyObject)
    func viewSegue(user dataObject: AnyObject)
}

class TableViewCell: UITableViewCell {

    
     var delegate:segueEditView!
    
    @IBOutlet weak var cellLabel: UILabel!
    var userId : String = "" 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editAction(_ sender: Any) {
        print("Edit Action", userId)
        var user = getUser()
        if(self.delegate != nil){ //Just to be safe.
            self.delegate.editSegue(user : user)
        }
        
    }
    
    @IBAction func viewAction(_ sender: Any) {
        print("View Action", userId)
        var user = getUser()
        print("view method", user.name)
        if(self.delegate != nil){ //Just to be safe.
            self.delegate.viewSegue(user : user)
        }
    }
    
    func getUser() -> User {
        var user = User();
        user.name = cellLabel.text!
        user.userId = userId
        return user
    }
}
