
import UIKit

protocol NavigationEditViewDelegate :class {
    func editNavigation(user: UserDetail)
    func viewNavigation(user: UserDetail)
}

class TableViewCell: UITableViewCell {

    var delegate : NavigationEditViewDelegate?
    var userId : Int?
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    
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
        let user = UserDetail();
        user.name = cellLabel.text!
        user.userId = userId
        return user
    }
}
