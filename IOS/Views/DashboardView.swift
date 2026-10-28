
import SwiftUI

struct DashboardView: View {
    var body: some View {
        List {
            NavigationLink("İşletmeler") {
                ShopListView()
            }

            NavigationLink("Sadakat Programları") {
                ProgramListView()
            }

            NavigationLink("Müşteri Kartları") {
                StampCardListView()
            }
        }
        .navigationTitle("Damgio Yönetimi")
    }
}
