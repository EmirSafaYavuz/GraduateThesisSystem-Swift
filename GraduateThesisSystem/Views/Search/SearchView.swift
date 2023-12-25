import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var isFilterSheetPresented = false
    // Diğer gerekli state'leri buraya ekleyebilirsiniz.

    var body: some View {
        NavigationView {
            VStack {
                TextField("Type something", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 2)
                    ).padding(.horizontal)
                Spacer()
                
            }
            .background(Color(UIColor.secondarySystemBackground))
            .navigationBarTitle("Search")
            .navigationBarItems(trailing:
                Button(action: {
                    self.isFilterSheetPresented = true
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .imageScale(.large)
                }
            )
            .sheet(isPresented: $isFilterSheetPresented) {
                FilterSheet()
            }
        }
    }
}

struct FilterSheet: View {
    // Filtreleme seçenekleri ve diğer gerekli state'leri buraya ekleyebilirsiniz.

    var body: some View {
        // Filtreleme sheet'i içeriği buraya eklenir.
        Text("Filtreleme seçenekleri burada gösterilecek.")
            .padding()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
