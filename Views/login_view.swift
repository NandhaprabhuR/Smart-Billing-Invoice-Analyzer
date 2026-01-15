import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Image(systemName: "chart.bar.doc.horizontal.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.blue)
                
                Text("Smart Billing Analyzer")
                    .font(.title).bold()
                
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Email Address", text: $viewModel.email)
                        .padding()
                        // FIX: Use .secondary background to avoid UIKit/UIColor errors
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(10)
                        // FIX: Use platform-neutral modifiers
                        .disableAutocorrection(true)
                    
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
                
                Button(action: { viewModel.login() }) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("Sign In")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, 50)
            .navigationDestination(isPresented: $viewModel.isAuthenticated) {
                DashboardView()
            }
        }
    }
}
