import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

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

            SecureField("Şifre", text: $password)
                .textFieldStyle(.roundedBorder)

            NavigationLink(destination: RoleSelectionView()) {
                Text("Giriş Yap")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Giriş")
    }
}
