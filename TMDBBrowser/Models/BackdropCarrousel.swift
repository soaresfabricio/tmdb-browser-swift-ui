//
//  BackdropCarrousel.swift
//  WeSplit
//
//  Created by Fabrício Soares on 26/04/20.
//  Copyright © 2020 Fabrício Soares. All rights reserved.
//

import Foundation

struct BackdropCarroussel: Decodable, Hashable {
    var page: Int?
    var results: [Movie]?
    var total_results: Int?
    var total_pages: Int?

    init(page: Int = 1, type: CarrouselType) {
        var path = ""

        switch type {
        case .Popular:
            path = "/movie/popular"
        case .NowPlaying:
            path = "/movie/now_playing"
        case .Upcoming:
            path = "/movie/upcoming"
        case .TopRated:
            path = "/movie/top_rated"
        }

        let url = URL(string: entryPointUrl + path + "?api_key=" + apiKey + "&page=\(page)")!

        do {
            let response = try Data(contentsOf: url)
            self = try JSONDecoder().decode(BackdropCarroussel.self, from: response)
        } catch {
            self.total_results = 0
            print(error.localizedDescription)
        }
    }
}
