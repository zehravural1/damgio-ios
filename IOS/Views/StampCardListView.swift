
import SwiftUI
import SwiftData

struct StampCardListView: View {
    @Query(sort: \StampCard.customerName)
    private var cards: [StampCard]

    var body: some View {
        List(cards) { card in
            VStack(alignment: .leading, spacing: 6) {
                Text(card.customerName)
                    .font(.headline)

                if let program = card.program {
                    Text(program.name)
                        .font(.subheadline)

                    Text("İşletme: \(program.shop?.name ?? "Belirtilmemiş")")
                        .font(.caption)
                }

                if let program = card.program {
                    Text(
                        "Damga: \(card.stampCount)/\(program.requiredStamps)"
                    )
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                    ProgressView(
                        value: Double(card.stampCount),
                        total: Double(max(program.requiredStamps, 1))
                    )
                }
            }
            .padding(.vertical, 5)
        }
        .navigationTitle("Müşteri Kartları")
    }
}
