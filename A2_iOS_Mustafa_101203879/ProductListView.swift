import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel = ProductViewModel()
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
            List {
                SearchBar(text: $searchText)
                    .listRowSeparator(.hidden)
                
                if filteredProducts.isEmpty {
                    ContentUnavailableView("No Products", systemImage: "tray", description: Text("Your product list is empty"))
                } else {
                    ForEach(filteredProducts, id: \.id) { product in
                        ProductRowView(product: product)
                            .listRowSeparator(.hidden)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Product Catalog")
            .onAppear {
                viewModel.fetchProducts()
            }
        }
    }
}

