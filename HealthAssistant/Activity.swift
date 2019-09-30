
import UIKit

class Activity: NSObject, NSCoding {
    var name = ""
    var time = ""
    var imageName = ""
    
    init(name: String, time: String, imageName: String) {
        self.name = name
        self.time = time
        self.imageName = imageName
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as? String
        let time = aDecoder.decodeObject(forKey: "time") as? String
        let imageName = aDecoder.decodeObject(forKey: "imageName") as? String
        self.init(name: name ?? "0", time: time ??  "0", imageName: imageName ?? "stationary")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(time, forKey: "time")
        aCoder.encode(imageName, forKey: "imageName")
    }
}
