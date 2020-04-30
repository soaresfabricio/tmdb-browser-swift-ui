//
//  PopularMovies.swift
//  WeSplit
//
//  Created by Fabrício Soares on 25/04/20.
//  Copyright © 2020 Fabrício Soares. All rights reserved.
//

import Foundation
import SDWebImageSwiftUI
import SwiftUI

enum CarrouselType {
    case Popular
    case NowPlaying
    case Upcoming
    case TopRated
}

struct BackdropCarrouselView: View {
    @State var model: BackdropCarrouselViewModel?
    var type: CarrouselType

    var body: some View {
        VStack(alignment: .leading) {
            if model == nil {
                LoadingView()
            } else if model?.carrousel.total_results == 0 {
                Text("Network Error. Check your connection and try again.")
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(model?.carrousel.results ?? [], id: \.self) { result in

                            NavigationLink(destination: MovieViewController(id: result.id!)) {
                                BackdropCardView(movie: result)

                            }.buttonStyle(PlainButtonStyle())
                        }

                    }.padding(.leading)
                }.animation(.easeInOut(duration: 1.0))
            }
        }.onAppear {
            if self.model == nil {
                DispatchQueue(label: "backdropcarrousel").async {
                    self.model = BackdropCarrouselViewModel(type: self.type)
                }
            }
        }
    }
}
