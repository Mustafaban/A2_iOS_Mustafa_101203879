import SwiftUI

struct ProductSearchView: View {
    @StateObject private var viewModel = ProductViewModel()
    @State private var searchText = ""
    
    var filteredProducts: [Product] {
        viewModel.products.filter { product in
            searchText.isEmpty ||
            (product.name?.localizedCaseInsensitiveContains(searchText) == true) ||
            (product.desc?.localizedCaseInsensitiveContains(searchText) == true)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search Product", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(filteredProducts, id: \.id) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        Text(product.name ?? "Unknown")
                    }
                }
            }
            .navigationTitle("Search")
            .onAppear {
                viewModel.fetchProducts()
            }
        }
    }
}

#Preview {
    ProductSearchView()
}
