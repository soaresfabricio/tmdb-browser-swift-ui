import Combine
import Foundation
import SDWebImageSwiftUI
import SwiftUI

struct HomeView: View {
//    @State var searchResult: SearchResult? = nil
//    @State var searchResult: String = ""
    
    @ObservedObject private var searchViewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchText: $searchViewModel.searchTerm).animation(.easeInOut(duration: 0.3))
                Spacer()
                
                if searchViewModel.searchTerm.count > 0 {
                        List(searchViewModel.results.sorted(by: { (a, b) -> Bool in
                            a.popularity ?? 0 > b.popularity ?? 0
                        }), id: \.self) { result in
                            
                            NavigationLink(destination: MovieViewController(id: result.id!)) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(result.title ?? "") (\(result.release_date?.prefix(4).description ?? ""))").bold()
                                        
                                        if result.title != result.original_title {
                                            Text("\(result.original_language ?? ""): \(result.original_title ?? "")").font(Font.system(size: 13))
                                        }
                                        
                                        Text(result.overview ?? "").font(Font.system(size: 11))
                                        Spacer()
                                    }
                                    Spacer()
                                    
                                    WebImage(url: getPosterUrl(quality: .w92, path: result.poster_path ?? "")).resizable().scaledToFit()
                                    
                                }.frame(height: 100)
                                
                            }.buttonStyle(PlainButtonStyle())
                            
                        }.resignKeyboardOnDragGesture()
                    
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        HStack {
                            Text("Popular").font(.title).fontWeight(.bold)
                            Spacer()
                            Text("see all").font(.subheadline).fontWeight(.bold).foregroundColor(Color(.systemBlue))
                        }.padding()
                        BackdropCarrouselView(type: .Popular)
                        
                        HStack {
                            Text("Now Playing").font(.title).fontWeight(.bold)
                            Spacer()
                            Text("see all").font(.subheadline).fontWeight(.bold).foregroundColor(Color(.systemBlue))
                        }.padding()
                        BackdropCarrouselView(type: .NowPlaying)
                        
                        HStack {
                            Text("Upcoming").font(.title).fontWeight(.bold)
                            Spacer()
                            Text("see all").font(.subheadline).fontWeight(.bold).foregroundColor(Color(.systemBlue))
                        }.padding()
                        BackdropCarrouselView(type: .Upcoming)
                        
                        HStack {
                            Text("Top Rated").font(.title).fontWeight(.bold)
                            Spacer()
                            Text("see all").font(.subheadline).fontWeight(.bold).foregroundColor(Color(.systemBlue))
                        }.padding()
                        BackdropCarrouselView(type: .TopRated)
                        
                    }.padding(0)
                }
            }.navigationBarTitle(Text("TMDB Browser"))
        }
        
        .tabItem {
            Image(systemName: "square.and.pencil")
            Text("Home")
        }
    }
}

public struct ListSeparatorStyleNoneModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content.onAppear {
            UITableView.appearance().separatorStyle = .none
        }.onDisappear {
            UITableView.appearance().separatorStyle = .singleLine
        }
    }
}

extension View {
    public func listSeparatorStyleNone() -> some View {
        modifier(ListSeparatorStyleNoneModifier())
    }
}
