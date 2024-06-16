//
//  NotesApp.swift
//  Notes
//  Assignment 4
//
//  Created by Rachel on 6/11/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @StateObject var noteApp = NoteViewModel()
    @State var note = NoteModel(title: "", notesdata: "")
    @AppStorage("uid") var email: String = ""
    @State private var isShowingAuthView = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($noteApp.notes) { $note in
                        NavigationLink(destination: NoteDetail(note: $note)) {
                            Text(note.title)
                        }
                    }
                    Section {
                        NavigationLink(destination: NoteDetail(note: $note)) {
                            Text("New note")
                                .foregroundColor(Color.gray)
                                .font(.system(size: 15))
                        }
                    }
                }
                .navigationTitle("Notes")
                .toolbar {
                    Button("Sign Out") {
                        signOut()
                    }
                }
                .onAppear {
                    noteApp.fetchData()
                }
                .refreshable {
                    noteApp.fetchData()
                }
            }
            .fullScreenCover(isPresented: $isShowingAuthView) {
                AuthView()
            }
        }
    }
    
    private func signOut() {
        do {
            try Auth.auth().signOut()
            email = ""
            isShowingAuthView = true
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
