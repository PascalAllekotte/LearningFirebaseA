//
//  AuthentificationVIew.swift
//  LearningFirebase
//
//  Created by Pascal Allekotte on 01.06.24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift


@MainActor
final class GoogleAuthentificationViewModel: ObservableObject {
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthetificationRepository.shared.signInWithGoogle(tokens: tokens)
        
    }
    
}


struct AuthenticationView: View {
    
    @StateObject private var viewModel = GoogleAuthentificationViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                SignInView(showSignInView: $showSignInView)
                } label: {
                    Text("Sign In With Email")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                }

                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                    Task {
                        do{
                            try await viewModel.signInGoogle()
                            showSignInView = false
                        } catch {
                            print(error)
                        }
                    }
                    
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Sign In")
        }
    }
}

#Preview {
    AuthenticationView(showSignInView: .constant(false))
}
