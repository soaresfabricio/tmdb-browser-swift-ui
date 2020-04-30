import Foundation
import SwiftUI

let entryPointUrl = "https://api.themoviedb.org/3"
let imagesEntryPoint = "https://image.tmdb.org/t/p/"

struct LoadingView: View {
    
    @State var spin = true
    
    var body: some View {
        Image(systemName: "arrow.2.circlepath.circle.fill")
            .resizable()
            .frame(width: 30, height: 30)
            .rotationEffect(.degrees(spin ? -360: 0) )
            .animation( Animation.linear(duration: 0.4).repeatForever(autoreverses: false) )
            .onAppear(){
                self.spin.toggle()
            }
        
    }

}
