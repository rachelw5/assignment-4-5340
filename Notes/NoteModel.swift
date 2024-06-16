//
//  NotesApp.swift
//  Notes
//  Assignment 4
//
//  Created by Rachel on 6/11/24.
//

import Foundation
import FirebaseFirestoreSwift

struct NoteModel : Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var notesdata: String
}
