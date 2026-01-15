import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // Home Screen (Billing Insights)
            DashboardView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            // Analysis Screen (Charts/Trends)
            AnalysisView()
                .tabItem {
                    Label("Analysis", systemImage: "chart.pie.fill")
                }
            
            // Profile Screen (User Settings & Logout)
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
        }
    }
}
