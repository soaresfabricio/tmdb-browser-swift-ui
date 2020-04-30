import SDWebImageSwiftUI
import SwiftUI

struct MovieViewController: View {
    @ObservedObject var movieViewModel = MovieViewModel()
    
    @State var id: Int
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        Group {
            if self.movieViewModel.movie.id == 0 {
                LoadingView()
            } else if self.movieViewModel.movie.id == -1 {
                Text("Network error. Check your Internet connection and try again.")
            } else {
                ScrollView(showsIndicators: false) {
//                    WebImage(url: getBackdropUrl(quality: .Medium, path: self.movieViewModel.movie.backdrop_path ?? ""))
//                        .resizable()
//                        .scaledToFit()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        // Buttons
//                        HStack {
//                            Image(systemName: "list.bullet").resizable().scaledToFit()
//                            Image(systemName: "heart").resizable().scaledToFit()
//                            Image(systemName: "bookmark").resizable().scaledToFit()
//                            Image(systemName: "star").resizable().scaledToFit()
//                        }.frame(height: 20).padding().background(Color.white).cornerRadius(30).shadow(radius: 10)
                        
                        WebImage(url: getPosterUrl(quality: .w342, path: self.movieViewModel.movie.poster_path ?? "")).resizable().scaledToFit().cornerRadius(10).shadow(radius: 20)
                        
                        VStack {
                            // Movie title
                            Text("\(self.movieViewModel.movie.title ?? "") ")
                                .font(.title).bold()
                            // Year and runtime
                            HStack {
                                Text("\(self.movieViewModel.movie.release_date?.prefix(4).description ?? "")")
                                Text("\(self.movieViewModel.movie.runtime?.description ?? "") minutes")
                            }.font(.caption).foregroundColor(Color(.systemGray))
                        }
                        
                        HStack {
                            ForEach(movieViewModel.movie.genres ?? [], id: \.self) { genre in
                                Text("\(genre.name ?? "")")
                                    .font(.caption)
                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .shadow(radius: 2)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("\(self.movieViewModel.movie.tagline ?? "")").font(.headline).bold()
                            
                            Text("\(self.movieViewModel.movie.overview ?? "")").font(.callout)
                        }
                        
                    }.padding(30)
                }
            }
        }
//    .navigationBarHidden(true)
        .navigationBarTitle("\(self.movieViewModel.movie.title ?? "")", displayMode: .inline).navigationBarItems(trailing: Image(systemName: "list.bullet").resizable().scaledToFit())
        
        .tabItem {
            Image(systemName: "square.and.pencil")
            Text("Home")
        }
        .onAppear {
            DispatchQueue(label: "movies").async {
                self.movieViewModel.id = self.id
            }
        }
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
