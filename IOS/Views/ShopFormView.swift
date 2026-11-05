import SwiftUI
import SwiftData

struct ShopFormView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    let shop: Shop?

    @State private var name: String
    @State private var address: String

    init(shop: Shop? = nil) {
        self.shop = shop
        _name = State(initialValue: shop?.name ?? "")
        _address = State(initialValue: shop?.address ?? "")
    }

    var body: some View {
        Form {
            Section("İşletme Bilgileri") {
                TextField("İşletme adı", text: $name)
                TextField("Adres", text: $address)
            }

            Button(shop == nil ? "İşletmeyi Kaydet" : "Değişiklikleri Kaydet") {
                if let shop {
                    shop.name = name
                    shop.address = address
                } else {
                    context.insert(
                        Shop(name: name, address: address)
                    )
                }

                dismiss()
            }
            .disabled(
                name.trimmingCharacters(in: .whitespaces).isEmpty ||
                address.trimmingCharacters(in: .whitespaces).isEmpty
            )
        }
        .navigationTitle(
            shop == nil ? "Yeni İşletme" : "İşletmeyi Düzenle"
        )
    }
}
