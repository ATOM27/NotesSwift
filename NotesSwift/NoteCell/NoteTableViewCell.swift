//
//  NoteTableViewCell.swift
//  NotesSwift
//
//  Created by Eugene Mekhedov on 26.09.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        headerLabel.text = ""
        descriptionTextView.text = ""
    }
    
    static let reuseIdentifierr = "NoteCell"
}
