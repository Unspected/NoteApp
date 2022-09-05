
import UIKit
import CoreData

var noteList = [Note]()

class NoteTableView: UITableViewController {
    
    var firstLoad = true
    
    func nonDeleteNotes() -> [Note] {
        
        var nonDeleteNotes: [Note] = [Note]()
        for note in noteList {
            if note.deleteData == nil {
                nonDeleteNotes.append(note)
            }
        }
        return nonDeleteNotes
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (firstLoad) {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let note = result as! Note
                    noteList.append(note)
                }
            } catch {
                print("Fetch failed")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCellID", for: indexPath) as! NoteCell
        
        let thisNote: Note!
        thisNote = nonDeleteNotes()[indexPath.row]
        
        cell.titleLabel.text = thisNote.title as String?
        cell.descriptionLabel.text = thisNote.desc as String?
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nonDeleteNotes().count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editNote", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editNote" {
            let indexPath = tableView.indexPathForSelectedRow
            
            let noteDetail = segue.destination as? NoteDetailVC
            
            let selectedNote: Note
            selectedNote = nonDeleteNotes()[indexPath!.row]
            noteDetail!.selectedNote = selectedNote
            
            tableView.deselectRow(at: indexPath!, animated: true)
            
            
        }
    }
}
