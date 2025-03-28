import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel = ProductViewModel()
    
    @State private var newName = ""
    @State private var newDesc = ""
    @State private var newPrice = ""
    @State private var newProvider = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.products, id: \.id) { product in
                    VStack(alignment: .leading) {
                        Text(product.name ?? "Unknown")
                            .font(.headline)
                        Text(product.desc ?? "No description")
                        Text("Price: \(product.price, specifier: "%.2f")")
                        Text("Provider: \(product.provider ?? "Unknown")")
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.deleteProduct(product)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                .navigationTitle("Products")
                
                VStack {
                    TextField("Name", text: $newName)
                    TextField("Description", text: $newDesc)
                    TextField("Price", text: $newPrice)
                    TextField("Provider", text: $newProvider)
                    Button("Add Product") {
                        guard let price = Double(newPrice) else { return }
                        viewModel.addProduct(name: newName, desc: newDesc, price: price, provider: newProvider)
                    }
                }
                .padding()
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        ProductListView()
    }
}

@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
