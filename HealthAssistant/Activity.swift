
import Foundation

class Activity: NSObject, NSCoding {
    var name = ""
    var time = ""
    
    init(name: String, time: String) {
        self.name = name
        self.time = time
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as? String
        let time = aDecoder.decodeObject(forKey: "time") as? String
        self.init(name: name ?? "0", time: time ??  "0")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(time, forKey: "time")
    }
}
