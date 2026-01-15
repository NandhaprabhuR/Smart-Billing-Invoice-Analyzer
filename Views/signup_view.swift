import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = LoginViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 25) {
            Image(systemName: "person.badge.plus")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.blue)
            
            Text("Create Account")
                .font(.title).bold()
            
            VStack(alignment: .leading, spacing: 15) {
                TextField("Email Address", text: $viewModel.email)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button(action: { viewModel.signUp() }) {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Register Now")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
            Button("Already have an account? Sign In") {
                dismiss()
            }
            .padding(.top, 10)
            
            Spacer()
        }
        .padding(.top, 50)
        .navigationDestination(isPresented: $viewModel.isAuthenticated) {
            MainTabView()
        }
    }
}
