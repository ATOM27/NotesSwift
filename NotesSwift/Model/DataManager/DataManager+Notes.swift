//
//  DataManager+Notes.swift
//  NotesSwift
//
//  Created by Eugene Mekhedov on 26.09.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

import Foundation
import CoreData

extension DataManager{
    func addNewNote(note: Note){
        let newNote = Notes(entity: NSEntityDescription.entity(forEntityName: "Notes", in: DataManager.sharedManager.persistentContainer.viewContext)!, insertInto: DataManager.sharedManager.persistentContainer.viewContext)
        newNote.header = note.header
        newNote.descriptionNote = note.descriptionText
        
        DataManager.sharedManager.saveContext()
    }
}
