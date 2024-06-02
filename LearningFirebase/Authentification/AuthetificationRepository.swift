//
//  AuthetificationRepository.swift
//  LearningFirebase
//
//  Created by Pascal Allekotte on 01.06.24.
//

import Foundation
import FirebaseAuth

enum AuthProviderOption : String {
    case email = "password"
    case google = "google.com"
    
}

final class AuthetificationRepository {
    
    static let shared = AuthetificationRepository()
    private init () {}
    
    func getAuthenticatedUser() throws -> AuthentificationModel{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthentificationModel(user: user)
    }
    
    func getProvider() throws -> [AuthProviderOption] {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
        }
        
        var providers: [AuthProviderOption] = []
        for provider in providerData {
            if let option = AuthProviderOption(rawValue: provider.providerID){
                providers.append(option)
            } else {
                assertionFailure("Provider option not found: \(provider.providerID)")
            }
        }
        return providers
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
// MARK: Alle Email Funktionen
extension AuthetificationRepository {
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthentificationModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthentificationModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthentificationModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthentificationModel(user: authDataResult.user)
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(newPassword: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.updatePassword(to: newPassword)
    }
    
    func updateEmail(newEmail: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.updateEmail(to: newEmail)
    }
    
}

extension AuthetificationRepository {
    
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignResultModel) async throws -> AuthentificationModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
        
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthentificationModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthentificationModel(user: authDataResult.user)
        
    }
    
}
