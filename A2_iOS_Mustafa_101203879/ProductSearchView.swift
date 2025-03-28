import SwiftUI

struct ProductSearchView: View {
    @StateObject private var viewModel = ProductViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search Product", text: .constant(""))  // Placeholder for the search bar
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(viewModel.products, id: \.id) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        Text(product.name ?? "Unknown")
                    }
                }
            }
            .navigationTitle("Search")
            .onAppear {
                viewModel.fetchProducts()
