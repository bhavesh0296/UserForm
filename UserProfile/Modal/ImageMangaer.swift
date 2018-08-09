
protocol ImageConfirmation : class {
    func saveConfirm(value:Bool)
    func deleteConfirm(value:Bool)
}

import Foundation
import UIKit

class ImageManager {
    
    weak var delegate : ImageConfirmation?
    
    init(delegate:ImageConfirmation){
        self.delegate = delegate
    }
    
    //Default init function
    init(){
    
    }
    
    //Save User image to document directory
    func saveImage(chosenImage: UIImage?, imageName: String)->String{
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = imageName+".jpg"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        print(fileURL)
        if let data = UIImageJPEGRepresentation(chosenImage!, 1.0){
            //            !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try data.write(to: fileURL)
                print("file saved")
                return fileName
            } catch {
                print("error saving file:", error)
                return ""
            }
        }
        return ""
    }
    
    //Return UIImage object of user Image
    func getImage(fileName : String)-> UIImage?{
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(fileName).path)
        }
        return nil
    }
    
    //Delete user image
    func deleteImage(fileName : String){
        print("delete image action is called")
        let filemanager = FileManager.default
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as NSString
        let destinationPath = documentsPath.appendingPathComponent(fileName)
        print(destinationPath)
        try? filemanager.removeItem(atPath: destinationPath)
        delegate?.deleteConfirm(value: true)
    }
}
