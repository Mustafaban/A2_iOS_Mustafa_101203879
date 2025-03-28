import SwiftUI

struct AddProductView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ProductViewModel()
    @State private var navigateToProductList = false
    
    @State private var name = ""
    @State private var desc = ""
    @State private var price = ""
    @State private var provider = ""
    @State private var errorMessage: String? = nil
    
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
                
                if let errorMessage = errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
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
        guard validateFields() else { return }
        
        if let priceValue = Double(price) {
            viewModel.addProduct(name: name, desc: desc, price: priceValue, provider: provider)
            navigateToProductList = true
        }
    }
    
    private func validateFields() -> Bool {
        if name.isEmpty || desc.isEmpty || price.isEmpty || provider.isEmpty {
            errorMessage = "All fields are required."
            return false
        }
        
        if Double(price) == nil {
            errorMessage = "Price must be a valid number."
            return false
        }
        
        errorMessage = nil
        return true
    }
}

#Preview {
    AddProductView()
}
