
import SwiftUI
import SwiftData

struct SampleDataLoader: ViewModifier {
    @Environment(\.modelContext) private var context
    @Query private var shops: [Shop]

    func body(content: Content) -> some View {
        content.task {
            do {
                let descriptor = FetchDescriptor<Shop>()
                let existingShops = try context.fetch(descriptor)

                guard existingShops.isEmpty else { return }

                try SampleData.createSampleData(context: context)
            } catch {
                print("Örnek veriler eklenemedi: \(error)")
            }
        }
    }
}
