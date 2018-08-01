//
//  ViewControllerPresenter.swift
//  UserProfile
//
//  Created by Daffodilmac-10 on 01/08/18.
//  Copyright © 2018 Daffodilmac-10. All rights reserved.
//
protocol ViewControllerDelegate:class {
    func goToEdit(user : UserDetail?)
    func gotoView(user : UserDetail)
}



import Foundation
class ViewPresenter {
    
    weak var delegate : ViewControllerDelegate?
    
    init(delegate: ViewControllerDelegate) {
        self.delegate = delegate
    }
    
    func moveToEdit(user : UserDetail?){
        delegate?.goToEdit(user: user)
    }
    
    func moveToView(user : UserDetail){
        delegate?.gotoView(user: user)
    }
    
}
