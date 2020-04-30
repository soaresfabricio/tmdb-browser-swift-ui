
import SwiftUI

struct ContentView: View {
    @State var spin = false

    var body: some View {
        TabView {
            HomeView()

//            MovieViewController(id: 157336)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
