import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel = ProductViewModel()
    @State private var searchText = ""
    @State private var showAddProductView = false
    
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
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .background(.clear)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                            )
                    }
                    .onDelete(perform: deleteProduct)
                }
            }
            .listStyle(PlainListStyle())
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Product Catalog")
            .navigationBarItems(
                trailing: Button(action: {
                    showAddProductView = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .navigationDestination(isPresented: $showAddProductView) {
                AddProductView()
            }
            .onAppear {
                viewModel.fetchProducts()
            }
        }
    }
    
    private func deleteProduct(at offsets: IndexSet) {
        for index in offsets {
            let product = filteredProducts[index]
            viewModel.deleteProduct(product)
        }
    }
}

