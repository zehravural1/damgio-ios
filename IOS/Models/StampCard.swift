import Foundation
import SwiftData

@Model
final class StampCard {
    var customerName: String
    var stampCount: Int
    var lifetimeStamps: Int
    var availableRewards: Int
    var program: Program?

    init(
        customerName: String,
        stampCount: Int = 0,
        lifetimeStamps: Int = 0,
        availableRewards: Int = 0,
        program: Program? = nil
    ) {
        self.customerName = customerName
        self.stampCount = stampCount
        self.lifetimeStamps = lifetimeStamps
        self.availableRewards = availableRewards
        self.program = program
    }
}
