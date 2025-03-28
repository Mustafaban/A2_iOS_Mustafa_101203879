import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "A2_iOS_Mustafa_101203879")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext

        for i in 1...5 {
            let product = Product(context: context)
            product.id = UUID()
            product.name = "Sample Product \(i)"
            product.desc = "This is a sample description for product \(i)"
            product.price = Double(i * 10)
            product.provider = "Provider \(i)"
        }

        do {
            try context.save()
        } catch {
            print("Failed to save preview data: \(error.localizedDescription)")
        }

        return controller
    }()
}
