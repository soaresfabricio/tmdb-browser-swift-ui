//
//  PopularMovies.swift
//  WeSplit
//
//  Created by Fabrício Soares on 25/04/20.
//  Copyright © 2020 Fabrício Soares. All rights reserved.
//

import Foundation
import SwiftUI

struct BackdropCarrouselView: Decodable, Hashable, View {
    var page: Int?
    var results: [Movie]?
    var total_results: Int?
    var total_pages: Int?
    
    init(page: Int = 1) {
        let url = URL(string: entryPointUrl + "/movie/popular" + "?api_key=" + apiKey + "&page=\(page)")!
        print(url)
        
        do {
            let response = try Data(contentsOf: url)
            self = try JSONDecoder().decode(BackdropCarrouselView.self, from: response)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
                VStack(alignment: .leading) {
                    Group {
                        HStack {
                            Text("Popular").font(.title).fontWeight(.bold)
                            Spacer()
                            Text("see all").font(.subheadline).fontWeight(.bold).foregroundColor(Color(.systemBlue))
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(results!, id: \.self) { result in
                                    VStack {
                                        
                                        AsyncImage(
                                            url: URL(string: backdropEntryPoint + result.backdrop_path!)!,
                                            placeholder: LoadingView()
                                        ).scaledToFit().frame(height: 140).cornerRadius(5).shadow(radius: 4)
                                        
                                                                                
                                        Text("\(result.title!)").font(.callout).bold().frame(maxHeight: 20)
                                        Text("\( result.release_date! )").font(.subheadline).foregroundColor(Color.gray)

                                        
                                    }.frame(maxWidth: 300, maxHeight: 200)
                                }
                                
                            }.padding(.leading)
                        }
                    }
                    
                }.padding()
            }
    
}
