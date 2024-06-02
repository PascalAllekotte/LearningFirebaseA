//
//  SettingsView.swift
//  LearningFirebase
//
//  Created by Pascal Allekotte on 01.06.24.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    
    @StateObject private var viewModel = AuthentificationViewModel()
    @Binding var showingSignInView: Bool
    
    var body: some View {
        Form {
            Button("Log out"){
                Task {
                    do {
                        try viewModel.signOut()
                        showingSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
            
            if viewModel.authProviders.contains(.email){
                emailSection
            }
            
            
            
        }
        .onAppear{
            viewModel.loadAuthProviders()
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView(showingSignInView: .constant(false))
}

extension SettingsView {
    
    private var emailSection: some View {
        Section {
            Button("Reset password"){
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("Password reset")
                    } catch {
                        print(error)
                    }
                }
            }
            
            
            Button("Update password"){
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("Password updated")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Update Email"){
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("Email updated")
                    } catch {
                        print(error)
                    }
                }
            }
        } header: {
            Text("Email functions")
        }
    }
}
