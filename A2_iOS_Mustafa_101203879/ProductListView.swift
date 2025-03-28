import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel = ProductViewModel()
    @State private var searchText = ""
    
    var filteredProducts: [Product] {
        viewModel.products.filter { product in
            searchText.isEmpty ||
            (
