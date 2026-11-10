import SwiftUI
import SwiftData

struct CashierStampView: View {
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \StampCard.customerName)
    private var cards: [StampCard]

    @State private var errorMessage = ""
    @State private var showError = false

    var body: some View {
        List {
            if cards.isEmpty {
                ContentUnavailableView(
                    "Müşteri kartı bulunamadı",
                    systemImage: "person.crop.rectangle"
                )
            }

            ForEach(cards) { card in
                VStack(alignment: .leading, spacing: 10) {
                    Text(card.customerName)
                        .font(.headline)

                    if let program = card.program {
                        Text(program.name)
                            .font(.subheadline)

                        Text("Damga: \(card.stampCount)/\(program.requiredStamps)")
                            .font(.subheadline)

                        Text("Kullanılabilir ödül: \(card.availableRewards)")
                            .font(.subheadline)

                        Button("Damga ekle") {
                            do {
                                try StampCardService.addStamp(
                                    to: card,
                                    context: modelContext
                                )
                            } catch {
                                errorMessage = error.localizedDescription
                                showError = true
                            }
                        }
                        .disabled(
                            program.requiredStamps <= 0 ||
                            card.stampCount >= program.requiredStamps
                        )

                        Button("Ödülü kullan") {
                            do {
                                try StampCardService.redeemReward(
                                    for: card,
                                    context: modelContext
                                )
                            } catch {
                                errorMessage = error.localizedDescription
                                showError = true
                            }
                        }
                        .disabled(card.availableRewards <= 0)
                        .tint(.green)
                    } else {
                        Text("Bu karta bağlı program bulunamadı.")
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("Kasiyer Paneli")
        .alert("İşlem yapılamadı", isPresented: $showError) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
}
