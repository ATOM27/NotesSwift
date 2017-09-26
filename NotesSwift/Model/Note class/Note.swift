//
//  Note.swift
//  NotesSwift
//
//  Created by Eugene Mekhedov on 26.09.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

import UIKit

class Note: NSObject {
    let header : String
    let descriptionText : String
    
     init(header: String, description: String) {
        self.header = header
        self.descriptionText = description
        super.init()
    }
}
