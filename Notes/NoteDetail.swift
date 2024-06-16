//
//  NotesApp.swift
//  Notes
//  Assignment 4
//
//  Created by Rachel on 6/11/24.
//

import SwiftUI

struct NoteDetail: View {
    
    @Binding var note : NoteModel
    @StateObject var noteApp = NoteViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Note Title", text: $note.title)
                .font(.system(size: 25))
                .fontWeight(.bold)
            TextEditor(text: $note.notesdata)
                .font(.system(size: 20))
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    noteApp.saveData(note: note)
                    note.title = ""
                    note.notesdata = ""
                } label: {
                    Text("Save")
                }
            }
        }
    }
}


//#Preview {
//    NoteDetail(note: .constant(NoteModel(title: "one", notesdata: "one note")))
//}
