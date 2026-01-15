import Foundation
import SwiftUI
internal import Combine

class DashboardViewModel: ObservableObject {
    @Published var currentInvoice: Invoice?
    @Published var billingHistory: [Invoice] = []
    @Published var anomalies: [String] = []
    @Published var isLoading = false
    
    func loadBillingData() {
        self.isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let mockInvoice = Invoice(
                id: "INV-2023-01",
                billingMonth: "October 2023",
                dataUsageGB: 85.5,
                callMinutes: 450,
                smsCount: 120,
                roamingCharges: 45.0,
                basePlanFee: 50.0,
                extraUsageCharges: 15.0
            )
            
            self.currentInvoice = mockInvoice
            self.billingHistory = [mockInvoice]
            self.checkForAnomalies(invoice: mockInvoice)
            self.isLoading = false
        }
    }
    
    private func checkForAnomalies(invoice: Invoice) {
        anomalies.removeAll()
        if invoice.roamingCharges > (invoice.totalAmount * 0.2) {
            anomalies.append("High Roaming: Roaming is 20% of your bill.")
        }
        if invoice.extraUsageCharges > 10 {
            anomalies.append("Usage Spike: Extra charges detected.")
        }
    }
    
    func exportPDF() {
        print("Exporting report for \(currentInvoice?.billingMonth ?? "")")
    }
}
