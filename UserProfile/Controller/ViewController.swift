import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var userProfileTableView: UITableView!
    
    var presenter : ViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialSetup()
    }
    
    func intialSetup(){
        userProfileTableView.delegate = self
        userProfileTableView.dataSource = self
        userProfileTableView.register(UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier:"TableViewCell")
        configureTableView()
        userProfileTableView.separatorStyle = .none
        presenter = ViewPresenter(delegate:self)
        userDetailArray = (presenter.getData())!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retrieveMessages()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.cellLabel.text = userDetailArray[indexPath.row].name
        cell.userId = indexPath.row
        cell.userImageView.image = presenter?.getuserImage(fileName : userDetailArray[indexPath.row].image! )
        cell.addressLabel.text = userDetailArray[indexPath.row].address
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetailArray.count
    }
    
    //TODO: Declare configureTableView here:
    func configureTableView(){
        userProfileTableView.estimatedRowHeight = 150
        userProfileTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.deleteRow(at: indexPath.row)
            userProfileTableView.reloadData()
        }
        
    }
    
    func retrieveMessages(){
       userProfileTableView.reloadData();
    }
    
    @IBAction func goToFormAction(_ sender: Any) {
        presenter?.moveToEdit(user: nil)
    }
}

extension ViewController : NavigationEditViewDelegate{
    func editNavigation(user : UserDetail) {
        presenter?.moveToEdit(user: user)
    }
    func viewNavigation(user : UserDetail) {
        presenter?.moveToView(user: user)
    }
}

extension ViewController : ViewControllerDelegate {
    
    func goToEdit(user : UserDetail?) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "FormViewController") as! FormViewController
        myVC.user = user
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    func gotoView(user : UserDetail) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "FormDetailViewController") as! FormDetailViewController
        myVC.user = user
        navigationController?.pushViewController(myVC, animated: true)
    }
}
