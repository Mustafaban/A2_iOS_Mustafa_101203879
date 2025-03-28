import SwiftUI

struct ProductRowView: View {
    let product: Product
    
    var body: some View {
        NavigationLink(destination: ProductDetailView(product: product)) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(product.name ?? "Unknown Product")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(product.desc ?? "No description")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            )
        }
    }
}
