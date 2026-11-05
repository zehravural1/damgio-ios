import SwiftUI
import SwiftData

struct ShopListView: View {
    @Environment(\.modelContext) private var context

    @Query(sort: \Shop.name)
    private var shops: [Shop]

    var body: some View {
        List {
            ForEach(shops) { shop in
                NavigationLink {
                    ShopFormView(shop: shop)
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(shop.name)
                            .font(.headline)

                        Text(shop.address)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        context.delete(shop)
                    } label: {
                        Label("Sil", systemImage: "trash")
                    }
                }
            }
        }
        .navigationTitle("İşletmeler")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    ShopFormView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
