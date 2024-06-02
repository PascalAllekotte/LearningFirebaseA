//
//  LearningFirebaseApp.swift
//  LearningFirebase
//
//  Created by Pascal Allekotte on 01.06.24.
//

import SwiftUI
import Firebase



class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      print("Configured Firbase")
    return true
  }
}

@main
struct LearningFirebaseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
            WindowGroup {
                NavigationStack{
                RootView()
            }
        }
    }
}
