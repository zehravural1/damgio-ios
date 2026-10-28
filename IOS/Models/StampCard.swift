import Foundation
import SwiftData

@Model
final class StampCard {
    var customerName: String
    var stampCount: Int
    var program: Program?

    init(
        customerName: String,
        stampCount: Int = 0,
        program: Program? = nil
    ) {
        self.customerName = customerName
        self.stampCount = stampCount
        self.program = program
    }
}