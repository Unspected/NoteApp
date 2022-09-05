import CoreData

@objc(Note)
class Note: NSManagedObject {
    @NSManaged var id: NSNumber!
    @NSManaged var title: NSString!
    @NSManaged var desc: NSString!
    @NSManaged var deleteData: Date?
    
    
}
