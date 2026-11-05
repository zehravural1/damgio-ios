import SwiftUI
import SwiftData

struct ProgramFormView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Query(sort: \Shop.name)
    private var shops: [Shop]

    let program: Program?

    @State private var name: String
    @State private var requiredStamps: Int
    @State private var reward: String
    @State private var selectedShop: Shop?

    init(program: Program? = nil) {
        self.program = program
        _name = State(initialValue: program?.name ?? "")
        _requiredStamps = State(initialValue: program?.requiredStamps ?? 10)
        _reward = State(initialValue: program?.reward ?? "")
        _selectedShop = State(initialValue: program?.shop)
    }

    var body: some View {
        Form {
            Section("Program Bilgileri") {
                TextField("Program adı", text: $name)

                Stepper(
                    "Gerekli damga: \(requiredStamps)",
                    value: $requiredStamps,
                    in: 1...100
                )

                TextField("Ödül", text: $reward)
            }

            Section("İşletme") {
                Picker("İşletme seç", selection: $selectedShop) {
                    Text("İşletme seçilmedi")
                        .tag(nil as Shop?)

                    ForEach(shops) { shop in
                        Text(shop.name)
                            .tag(shop as Shop?)
                    }
                }
            }

            Button(program == nil ? "Programı Kaydet" : "Değişiklikleri Kaydet") {
                if let program {
                    program.name = name
                    program.requiredStamps = requiredStamps
                    program.reward = reward
                    program.shop = selectedShop
                } else {
                    let newProgram = Program(
                        name: name,
                        requiredStamps: requiredStamps,
                        reward: reward,
                        shop: selectedShop
                    )
                    context.insert(newProgram)
                }

                dismiss()
            }
            .disabled(
                name.trimmingCharacters(in: .whitespaces).isEmpty ||
                reward.trimmingCharacters(in: .whitespaces).isEmpty
            )
        }
        .navigationTitle(
            program == nil ? "Yeni Program" : "Programı Düzenle"
        )
    }
}
