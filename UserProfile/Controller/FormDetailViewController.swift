
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
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FormDetailViewPresenter(delegate: self)
        presenter?.viewDetail()
    }
}

extension FormDetailViewController : FormDetailViewDelegate{
    
    //set the deatil in the form view 
    func showDetail(){
        nameLabel.text = userDetailArray[(user?.userId)!].name
        genderLabel.text = userDetailArray[(user?.userId)!].gender
        phoneLabel.text = userDetailArray[(user?.userId)!].phone
        dobLabel.text = userDetailArray[(user?.userId)!].dob
        emailLabel.text = userDetailArray[(user?.userId)!].email
        addressLabel.text = userDetailArray[(user?.userId)!].address
        userImage.image = presenter?.getUserImage(fileName: userDetailArray[(user?.userId)!].image)
        
    }
}
