import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    private var canContinue: Bool {
        email.contains("@") &&
        email.contains(".") &&
        !password.isEmpty
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("damgio.")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Hesabına giriş yap")
                .font(.title2)

            TextField("E-posta adresi", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

            SecureField("Şifre", text: $password)
                .textFieldStyle(.roundedBorder)

            NavigationLink(
    destination: RoleSelectionView(
        customerEmail: email.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).lowercased()
    )
) {
                Text("Devam et")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!canContinue)

            Text("Bu sürümde giriş ekranı demo amaçlıdır. Gerçek hesap doğrulaması yapılmaz.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationTitle("Giriş")
    }
}
