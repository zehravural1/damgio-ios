
import SwiftUI

@main
struct DamgioApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                WelcomeView()
            }
        }
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
                RoleSelectionView()
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

    var body: some View {
        VStack(spacing: 12) {
            Text(role.displayName)
                .font(.title)

            Text("Bu rolün ana ekranı daha sonra geliştirilecek.")
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationTitle(role.rawValue)
    }
}
