import SwiftUI
import Charts // iOS 16+ Framework

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView("Analyzing Bill...")
                } else if let invoice = viewModel.currentInvoice {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // Total Bill Card
                        TotalBillCard(amount: invoice.totalAmount, month: invoice.billingMonth)
                        
                        // Anomaly Detection Section
                        if !viewModel.anomalies.isEmpty {
                            AnomalySection(alerts: viewModel.anomalies)
                        }
                        
                        // Visual Analytics
                        Text("Usage Breakdown").font(.headline)
                        UsageChartView(invoice: invoice)
                        
                        // Detailed Breakdown
                        VStack(spacing: 12) {
                            DetailRow(label: "Data Usage", value: "\(invoice.dataUsageGB) GB")
                            DetailRow(label: "Voice", value: "\(invoice.callMinutes) Mins")
                            DetailRow(label: "Roaming", value: "$\(invoice.roamingCharges)")
                        }
                        .padding()
                        .background(Color(.blue))
                        .cornerRadius(12)
                        
                        Button(action: { viewModel.exportPDF() }) {
                            Label("Export PDF Report", systemImage: "doc.text.fill")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Billing Insights")
            .onAppear { viewModel.loadBillingData() }
        }
    }
}

// Sub-component for Charts
struct UsageChartView: View {
    let invoice: Invoice
    
    var body: some View {
        Chart {
            BarMark(x: .value("Type", "Base"), y: .value("Value", invoice.basePlanFee))
            BarMark(x: .value("Type", "Roaming"), y: .value("Value", invoice.roamingCharges))
            BarMark(x: .value("Type", "Extra"), y: .value("Value", invoice.extraUsageCharges))
        }
        .frame(height: 200)
        .foregroundColor(.blue)
    }
}

struct TotalBillCard: View {
    let amount: Double
    let month: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(month).font(.caption).textCase(.uppercase)
            Text("$\(amount, specifier: "%.2f")")
                .font(.system(size: 40, weight: .bold, design: .rounded))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(15)
    }
}

struct AnomalySection: View {
    let alerts: [String]
    var body: some View {
        VStack(alignment: .leading) {
            Label("Anomalies Detected", systemImage: "exclamationmark.triangle.fill")
                .foregroundColor(.orange)
                .font(.headline)
            ForEach(alerts, id: \.self) { alert in
                Text("• \(alert)").font(.subheadline).padding(.top, 2)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.orange.opacity(0.1))
        .cornerRadius(12)
    }
}

struct DetailRow: View {
    var label: String
    var value: String
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value).bold()
        }
    }
}
