import SwiftUI

struct ProductDetailView: View {
    let product: Product
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(product.name ?? "Unknown Product")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(product.desc ?? "No description available")
                    .foregroundColor(.secondary)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Price")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("$\(product.price, specifier: "%.2f")")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    Text("Provider: \(product.provider ?? "Unknown")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
                )
                
                Spacer()
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Product Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
