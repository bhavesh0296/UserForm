//
//  ViewController.swift
//  UserProfile
//
//  Created by Daffodilmac-10 on 23/07/18.
//  Copyright © 2018 Daffodilmac-10. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var userProfileTableView: UITableView!
    
    var presenter : ViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProfileTableView.delegate = self
        userProfileTableView.dataSource = self
       
        userProfileTableView.register(UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier:"TableViewCell")
        configureTableView()
        userProfileTableView.separatorStyle = .none
        
        print("---View Controller view did load method is called")
        presenter = ViewPresenter(delegate:self)
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("--view Controller view Appear method is called---")
        retrieveMessages()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.cellLabel.text = userDetailArray[indexPath.row].name
        cell.userId = indexPath.row
        cell.delegate = self as NavigationEditViewDelegate
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetailArray.count
    }
    
    //TODO: Declare configureTableView here:
    func configureTableView(){
        userProfileTableView.rowHeight = UITableViewAutomaticDimension
        userProfileTableView.estimatedRowHeight = 150
        
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userDetailArray.remove(at: indexPath.row)
            //            userProfileTableView.deleteRows(at: [indexPath], with: .top)
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

