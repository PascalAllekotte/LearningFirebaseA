//
//  SignInView.swift
//  LearningFirebase
//
//  Created by Pascal Allekotte on 01.06.24.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject private var viewModel = AuthentificationViewModel()
    @Binding var showSignInView : Bool
    
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("Email...", text: $viewModel.email)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                SecureField("Password...", text: $viewModel.password)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                
                Button{
                    Task {
                        do{
                            try await viewModel.signUp()
                            showSignInView = false
                            return
                        } catch {
                            print(error)
                        }
                        do{
                            try await viewModel.signIn()
                            showSignInView = false
                            return
                        } catch {
                            print(error)
                        }
                    }
                    
                } label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                }
                Spacer()
                
                
            }
            .padding()
            
        }
        .navigationTitle("Sign In With Email")
    }
}

#Preview {
    SignInView(showSignInView: .constant(false))
}
