import SwiftUI

struct ProductDetailView: View {
    let product: Product
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(product.name ?? "Unknown Product")
                    .font(.title



