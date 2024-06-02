//
//  RootView.swift
//  LearningFirebase
//
//  Created by Pascal Allekotte on 01.06.24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showingSignInView: Bool = false
    
    var body: some View {
        ZStack{
            if !showingSignInView{
                NavigationStack{
                    SettingsView(showingSignInView: $showingSignInView)
                    
                }
            }
        }
        .onAppear{
            let authUser = try? AuthetificationRepository.shared.getAuthenticatedUser()
            self.showingSignInView = authUser == nil 
            
        }
        .fullScreenCover(isPresented: $showingSignInView){
            NavigationStack{
                AuthenticationView(showSignInView: $showingSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
