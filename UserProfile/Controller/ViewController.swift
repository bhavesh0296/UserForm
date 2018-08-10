import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var userProfileTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var presenter : ViewPresenter!
    var tableReloadData : [UserDetail]?
    
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retrieveMessages()
        searchBar.text=""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
//        cell.cellLabel.text = userDetailArray[indexPath.row].name
//        cell.userId = indexPath.row
//        cell.userImageView.image = presenter?.getuserImage(fileName : userDetailArray[indexPath.row].image! )
//        cell.addressLabel.text = userDetailArray[indexPath.row].address
//        cell.delegate = self
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.cellLabel.text = tableReloadData![indexPath.row].name
        cell.userId = indexPath.row
        cell.userImageView.image = presenter?.getuserImage(fileName : tableReloadData![indexPath.row].image! )
        cell.addressLabel.text = tableReloadData![indexPath.row].address
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableReloadData!.count
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
        userDetailArray = (presenter.getData())!
        tableReloadData = userDetailArray
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
        myVC.user = tableReloadData?[(user?.userId)!]
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    func gotoView(user : UserDetail) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "FormDetailViewController") as! FormDetailViewController
        myVC.user = user
        navigationController?.pushViewController(myVC, animated: true)
    }
}

//MARK :- UI Search Bar Methods
extension ViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            tableReloadData = userDetailArray
        }else{
            tableReloadData = userDetailArray.filter({(UserDetail)->Bool in
                return UserDetail.name.lowercased().contains(searchText.lowercased())
            })
        }
        userProfileTableView.reloadData()        
    }
}
