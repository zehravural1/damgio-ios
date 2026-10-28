import Foundation
import SwiftData

@Model
final class Program {
    var name: String
    var requiredStamps: Int
    var reward: String
    var shop: Shop?

    init(
        name: String,
        requiredStamps: Int,
        reward: String,
        shop: Shop? = nil
    ) {
        self.name = name
        self.requiredStamps = requiredStamps
        self.reward = reward
        self.shop = shop
    }
}