
import SwiftUI
import SwiftData

struct ShopListView: View {
    @Query(sort: \Shop.name) private var shops: [Shop]

    var body: some View {
        List(shops) { shop in
            VStack(alignment: .leading, spacing: 4) {
                Text(shop.name)
                    .font(.headline)

                Text(shop.address)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("İşletmeler")
    }
}
