//
//  FormDetailViewPresenter.swift
//  UserProfile
//
//  Created by Daffodilmac-10 on 01/08/18.
//  Copyright © 2018 Daffodilmac-10. All rights reserved.
//

protocol FormDetailViewDelegate : class{
    func showDetail()
}


import Foundation

class FormDetailViewPresenter{
    
    weak var delegate : FormDetailViewDelegate?
    
    init(delegate:FormDetailViewDelegate) {
        self.delegate = delegate
    }
    
    func viewDetail(){
            delegate?.showDetail()
    }
    
    
    
}
