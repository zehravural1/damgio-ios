
import SwiftUI
import SwiftData

struct ProgramListView: View {
    @Query(sort: \Program.name) private var programs: [Program]

    var body: some View {
        List(programs) { program in
            VStack(alignment: .leading, spacing: 6) {
                Text(program.name)
                    .font(.headline)

                Text("Ödül: \(program.reward)")
                    .font(.subheadline)

                Text("Gerekli damga: \(program.requiredStamps)")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                if let shop = program.shop {
                    Text("İşletme: \(shop.name)")
                        .font(.caption)
                }
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Sadakat Programları")
    }
}
