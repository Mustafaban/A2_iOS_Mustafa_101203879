import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ProductListView()
                .tabItem {
                    Label("Products", systemImage: "cube.box")
                }
            
            ProductSearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            AddProductView()
                .tabItem {
                    Label("Add", systemImage: "plus.circle.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}


