import SwiftUI
import FirebaseCore // Since you are setting up Firebase

@main
struct SmartBillingApp: App {
    
    // Initialize Firebase
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            // This is where you tell the app which screen to show first
            LoginView()
        }
    }
}
