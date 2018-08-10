
protocol FormDetailViewDelegate : class{
    func showDetail()
}

import Foundation
import UIKit
class FormDetailViewPresenter{
    
    weak var delegate : FormDetailViewDelegate?
    
    init(delegate:FormDetailViewDelegate) {
        self.delegate = delegate
    }
    
    func viewDetail(){
            delegate?.showDetail()
    }
    func getUserImage(fileName: String?)-> UIImage?{
        let imageManager = ImageManager()
        return imageManager.getImage(fileName: (fileName)!)
    }
}
