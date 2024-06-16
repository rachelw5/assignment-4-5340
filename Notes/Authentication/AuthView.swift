//
//  NotesApp.swift
//  Notes
//  Assignment 4
//
//  Created by Rachel on 6/11/24.
//

import SwiftUI
import FirebaseAuth

@MainActor
class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var userIsLoggedIn = false
}

struct AuthView: View {
    
    @StateObject private var authvm = AuthViewModel()
    
    var body: some View {
        if authvm.userIsLoggedIn {
            //go to notes
            ContentView()
        } else {
            content
        }
    }
    
    var content: some View {
        NavigationStack{
            VStack {
                TextField("Email", text: $authvm.email)
                    .padding()
                    .font(.system(size: 20))
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                SecureField("Password", text: $authvm.password)
                    .padding()
                    .font(.system(size: 20))
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                Button {
                    login()
                } label: {
                    Text("Sign In")
                        .padding()
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                HStack {
                    Text("Don't have an account?")
                    Button {
                        register()
                    } label: {
                        Text("Sign Up")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
            }
            .padding()
            .navigationTitle("Notes App")
            .onAppear() {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        authvm.userIsLoggedIn.toggle()
                    }
                }
            }
        }
        
    }
    
    func login() {
        Auth.auth().signIn(withEmail: authvm.email, password: authvm.password) {result, error in
            if error != nil {
                print("User not found. \(error!.localizedDescription)")
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: authvm.email, password: authvm.password) {result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
}


#Preview {
    AuthView()
}


