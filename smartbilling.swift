import SwiftUI
import FirebaseCore

@main
struct SmartBillingApp: App {
    
    // Initialize Firebase
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            // If this still shows an error, ensure LoginView.swift
            // is in the same folder/target as this file.
            LoginView()
        }
    }
}
