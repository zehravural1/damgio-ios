
import Foundation

enum UserRole: String, CaseIterable, Identifiable {
    case admin = "Admin"
    case cashier = "Cashier"
    case customer = "Customer"

    var id: String {
        rawValue
    }

    var displayName: String {
        switch self {
        case .admin:
            return "İşletme Sahibi"
        case .cashier:
            return "Kasiyer"
        case .customer:
            return "Müşteri"
        }
    }
}
git status