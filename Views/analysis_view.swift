import SwiftUI

struct AnalysisView: View {
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Monthly Trends").font(.headline)
                    
                    if let invoice = viewModel.currentInvoice {
                        UsageChartView(invoice: invoice)
                            .padding()
                            .background(Color.secondary.opacity(0.1))
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("Analysis")
            .onAppear { viewModel.loadBillingData() }
        }
    }
}//
//  analysis_view.swift
//  Smart Billing & Invoice Analyzer App
//
//  Created by Nandhaprabhur on 15/01/26.
//

