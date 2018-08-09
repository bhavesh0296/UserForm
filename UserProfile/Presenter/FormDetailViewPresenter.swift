
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
