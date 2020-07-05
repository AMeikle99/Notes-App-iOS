//
//  CoreDataHelper.swift
//  MakeSchoolNotes
//
//  Created by Aiden Meikle on 05/07/2020.
//  Copyright © 2020 MakeSchool. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistantContainer = appDelegate.persistentContainer
        let context = persistantContainer.viewContext
        
        return context
    }()
    
    static func newNote() -> Note {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        
        return note
    }
    
    static func saveNote() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func deleteNote(note: Note){
        context.delete(note)
        
        saveNote()
    }
    
    static func retrieveNotes() -> [Note] {
        
        do {
            let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
            let results = try context.fetch(fetchRequest).sorted(by: {$0.modificationTime! > $1.modificationTime!})
            
            return results
        }catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
}
