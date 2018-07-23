//
//  ViewController.swift
//  UserProfile
//
//  Created by Daffodilmac-10 on 23/07/18.
//  Copyright © 2018 Daffodilmac-10. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, segueEditView {
   

    @IBOutlet weak var userProfileTableView: UITableView!
    
    
    var userArray : [User] = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userProfileTableView.delegate = self
        userProfileTableView.dataSource = self
        
        userProfileTableView.register(UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier:"TableViewCell")
        configureTableView()
        userProfileTableView.separatorStyle = .none
        retrieveMessages()
        
        var user = User()
        user.name = "Bhavesh"
        user.userId = "2500"
        userArray.append(user)
        var user2 = User()
        user2.name = "Brijesh"
        user2.userId = "2515"
        userArray.append(user2)
        
        
        print("View Controller view lod method is called-------------")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("------view Appear method is called")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.cellLabel.text = userArray[indexPath.row].name
        cell.userId = userArray[indexPath.row].userId
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    //TODO: Declare configureTableView here:
    func configureTableView(){
        userProfileTableView.rowHeight = UITableViewAutomaticDimension
        userProfileTableView.estimatedRowHeight = 120
        
        
    }
    
    func retrieveMessages(){
        userProfileTableView.reloadData();
    }
    
   
    
    func editSegue(user dataobject: AnyObject) {
        self.performSegue(withIdentifier: "goToEdit", sender:dataobject )
    }
    
    func viewSegue(user dataObject: AnyObject) {
        self.performSegue(withIdentifier: "goToView", sender:dataObject )
    }
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToEdit") {
            let secondViewController = segue.destination as! FormViewController
            let user = sender as! User
            secondViewController.user = user
            secondViewController.isFormFilled = true
        }else if(segue.identifier == "goToView") {
            let secondViewController = segue.destination as! FormDetailViewController
            let user = sender as! User
            secondViewController.user = user
            secondViewController.isView = true
         }
        
    }
    
    @IBAction func goToFormAction(_ sender: Any) {
        print("gotoFormSegue")
        performSegue(withIdentifier: "goToForm", sender: self)
    }
    
    
    
}

