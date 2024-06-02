//
//  AuthentificationViewModel.swift
//  LearningFirebase
//
//  Created by Pascal Allekotte on 01.06.24.
//

import Foundation

@MainActor
final class AuthentificationViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var authProviders: [AuthProviderOption] = []
    
    func loadAuthProviders(){
        if let providers = try? AuthetificationRepository.shared.getProvider() {
            authProviders = providers
        }
    }
    
    func signOut() throws {
       try AuthetificationRepository.shared.signOut()
    }
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        try await
        AuthetificationRepository.shared.createUser(email: email, password: password)
        print("Success")
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        try await
        AuthetificationRepository.shared.signInUser(email: email, password: password)
        print("Success")
    }
    
    func resetPassword() async throws {
        let authUser = try AuthetificationRepository.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
                
        try await AuthetificationRepository.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws {
        let email = "pascal@test2.de"
        try await AuthetificationRepository.shared.updateEmail(newEmail: email)
    }
    
    func updatePassword() async throws {
        let password = "Hello123"
        try await AuthetificationRepository.shared.updatePassword(newPassword: password)
    }
}
