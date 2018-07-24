//
//  ViewController.swift
//  UserProfile
//
//  Created by Daffodilmac-10 on 23/07/18.
//  Copyright © 2018 Daffodilmac-10. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, segueEditView {
   

    @IBOutlet weak var userProfileTableView: UITableView!
    
    
    var userArray : [User] = [User]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProfileTableView.delegate = self
        userProfileTableView.dataSource = self
       
        userProfileTableView.register(UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier:"TableViewCell")
        configureTableView()
        userProfileTableView.separatorStyle = .none
        
        print("---View Controller view did load method is called")
     
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
        userArray =  getAllUser()
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
    
    // DB Management func
    
    func getAllUser()->[User]{
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        request.returnsObjectsAsFaults = false
        var userDetail : [User] = [User]()
        do {
           let result = try context.fetch(request)
           for data in result as! [NSManagedObject] {
                let user = UserDetail()
                user.name = data.value(forKey: "name") as! String
                user.userId = data.value(forKey: "userId") as! String
                userDetail.append(user)
            }
        } catch {
           print("Failed")
            
         }
        return userDetail
    }
    
}

