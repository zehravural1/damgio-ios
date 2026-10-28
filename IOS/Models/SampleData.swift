
import Foundation
import SwiftData

enum SampleData {
    static func createSampleData(
        context: ModelContext
    ) throws {
        let shop = Shop(
            name: "Coffee House",
            address: "Ankara"
        )

        let program = Program(
            name: "Kahve Sadakat Programı",
            requiredStamps: 10,
            reward: "1 ücretsiz kahve",
            shop: shop
        )

        let card = StampCard(
            customerName: "Zehra",
            stampCount: 3,
            program: program
        )

        context.insert(shop)
        context.insert(program)
        context.insert(card)

        try context.save()
    }
}
