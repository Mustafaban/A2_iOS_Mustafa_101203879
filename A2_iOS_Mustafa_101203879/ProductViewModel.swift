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
}
