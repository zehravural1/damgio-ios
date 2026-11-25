import SwiftUI
import SwiftData

struct StampCardListView: View {
    @Query private var cards: [StampCard]

    init(customerEmail: String) {
        let normalizedEmail = customerEmail
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        _cards = Query(
            filter: #Predicate<StampCard> { card in
                card.customerEmail == normalizedEmail
            },
            sort: [SortDescriptor(\StampCard.customerName)]
        )
    }

    var body: some View {
        Group {
            if cards.isEmpty {
                ContentUnavailableView(
                    "Henüz sadakat kartın yok",
                    systemImage: "ticket",
                    description: Text("Bu e-posta adresine bağlı kart bulunamadı.")
                )
            } else {
                List(cards) { card in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(card.program?.shop?.name ?? "İşletme belirtilmemiş")
                            .font(.headline)

                        Text(card.program?.name ?? "Program belirtilmemiş")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        if let program = card.program {
                            HStack {
                                Text("Damgaların")
                                Spacer()
                                Text("\(card.stampCount)/\(program.requiredStamps)")
                                    .fontWeight(.semibold)
                            }

                            ProgressView(
                                value: Double(min(card.stampCount, program.requiredStamps)),
                                total: Double(max(program.requiredStamps, 1))
                            )

                            if card.availableRewards > 0 {
                                Label(
                                    "\(card.availableRewards) kazanılmış ödül",
                                    systemImage: "gift.fill"
                                )
                                .foregroundStyle(.green)

                                Text(program.reward)
                                    .font(.subheadline)
                            } else {
                                Text("Henüz kullanılabilir ödül yok.")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

                            Text("Toplam kazanılan damga: \(card.lifetimeStamps)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationTitle("Sadakat Kartlarım")
    }
}