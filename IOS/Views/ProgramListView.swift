import SwiftUI
import SwiftData

struct ProgramListView: View {
    @Environment(\.modelContext) private var context

    @Query(sort: \Program.name)
    private var programs: [Program]

    var body: some View {
        List {
            ForEach(programs) { program in
                NavigationLink {
                    ProgramFormView(program: program)
                } label: {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(program.name)
                            .font(.headline)

                        Text("Damga: \(program.requiredStamps)")

                        Text("Ödül: \(program.reward)")
                            .foregroundStyle(.secondary)

                        Text("İşletme: \(program.shop?.name ?? "Belirtilmedi")")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        context.delete(program)
                    } label: {
                        Label("Sil", systemImage: "trash")
                    }
                }
            }
        }
        .navigationTitle("Sadakat Programları")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    ProgramFormView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
