import SwiftUI

struct AddProductView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ProductViewModel()
    @State private var navigateToProductList = false
    
    @State private var name = ""
    @State private var desc = ""
    @State private var price = ""
    @State private var provider = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Product Name", text: $name)
                        .autocorrectionDisabled()
                    
                    TextField("Description", text: $desc)
                        .autocorrectionDisabled()
                    
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                    
                    TextField("Provider", text: $provider)
                        .autocorrectionDisabled()
                }
                
                Section {
                    Button(action: addProduct) {
                        Text("Add Product")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(isFormValid ? Color.blue : Color.gray)
                            )
                    }
                    .disabled(!isFormValid)
                }
            }
            .navigationTitle("Add Product")
            .navigationBarItems(
                trailing: Button("Cancel") {
                    dismiss()
                }
            )
            .navigationDestination(isPresented: $navigateToProductList) {
                ProductListView()
            }
        }
    }
    
    private var isFormValid: Bool {
        !name.isEmpty && !desc.isEmpty && !price.isEmpty && !provider.isEmpty && Double(price) != nil
    }
    
    private func addProduct() {
        // This will be implemented in the next commit
    }
}

#Preview {
    AddProductView()
}
