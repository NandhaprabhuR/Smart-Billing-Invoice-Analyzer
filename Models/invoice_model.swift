import Foundation

struct Invoice: Identifiable, Codable {
    let id: String
    let billingMonth: String
    let dataUsageGB: Double
    let callMinutes: Int
    let smsCount: Int
    let roamingCharges: Double
    let basePlanFee: Double
    let extraUsageCharges: Double
    
    var totalAmount: Double {
        return basePlanFee + extraUsageCharges + roamingCharges
    }
}

struct BillingSummary {
    let category: String
    let amount: Double
    let percentage: Double
}
