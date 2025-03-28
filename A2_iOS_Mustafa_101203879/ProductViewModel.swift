import Foundation
import CoreData

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    
    private let context = PersistenceController.shared.container.viewContext

    init() {
        fetchProducts()
    }

    func fetchProducts() {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        do {
            products = try context.fetch(request)
        } catch {
            print("Failed to fetch products: \(error.localizedDescription)")
        }
    }

    func addProduct(name: String, desc: String, price: Double, provider: String) {
        let newProduct = Product(context: context)
        newProduct.id = UUID()
        newProduct.name = name
        newProduct.desc = desc
        newProduct.price = price
        newProduct.provider = provider

        saveContext()
    }

    func deleteProduct(_ product: Product) {
        context.delete(product)
        saveContext()
    }

    func saveContext() {
        do {
            try context.save()
            fetchProducts()
        } catch {
            print("Error saving Core Data: \(error.localizedDescription)")
        }
    }
}
