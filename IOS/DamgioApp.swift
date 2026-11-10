import SwiftUI
import SwiftData

@main
struct DamgioApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                WelcomeView()
            }
            .modifier(SampleDataLoader())
        }
        .modelContainer(for: [
            Shop.self,
            Program.self,
            StampCard.self
        ])
    }
}

struct WelcomeView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("damgio.")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Dijital sadakat kartın")
                .font(.headline)

            NavigationLink("Devam et") {
                LoginView()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Damgio")
    }
}

struct RoleSelectionView: View {
    var body: some View {
        List(UserRole.allCases) { role in
            NavigationLink {
                RoleHomeView(role: role)
            } label: {
                Text(role.displayName)
            }
        }
        .navigationTitle("Kullanıcı türü")
    }
}

struct RoleHomeView: View {
    let role: UserRole

    @ViewBuilder
    var body: some View {
        switch role {
        case .admin:
            DashboardView()

        case .cashier:
    CashierStampView()

        case .customer:
            StampCardListView()
        }
    }
}