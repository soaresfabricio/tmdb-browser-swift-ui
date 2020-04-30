import Foundation
import SDWebImageSwiftUI
import SwiftUI

struct BackdropCardView: View {
    @State var movie: Movie
    
    var body: some View {
        VStack {
            WebImage(url: getPosterUrl(quality: .w185, path: self.movie.poster_path ?? "")).resizable()
                .frame(width: 154, height: 228, alignment: .center).scaledToFit().cornerRadius(5).shadow(radius: 4)
            Text("\(movie.title!)").font(.caption).bold().frame(maxWidth: 100, maxHeight: 20)            
        }.frame(maxWidth: 154*1.3, maxHeight: 228*1.3).animation(.easeInOut(duration: 1.0))
    }
}
