import SwiftUI
import FirebaseAuth
internal import Combine

class ProfileViewModel: ObservableObject {
    // We give these default values so Swift can create the initializer automatically
    @Published var userEmail: String = ""
    @Published var isLoggedOut = false
    
    init() {
        // Set the email when the ViewModel is created
        self.userEmail = Auth.auth().currentUser?.email ?? "User"
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            // Setting this to true triggers the navigation back to LoginView
            self.isLoggedOut = true
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Account Information")) {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.blue)
                        Text("Email")
                        Spacer()
                        Text(viewModel.userEmail)
                            .foregroundColor(.secondary)
                    }
                }
                
                Section {
                    Button(role: .destructive, action: { viewModel.signOut() }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text("Sign Out")
                        }
                    }
                }
            }
            .navigationTitle("Profile")
            // Navigation destination to return to Login screen upon logout
            .navigationDestination(isPresented: $viewModel.isLoggedOut) {
                LoginView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}
