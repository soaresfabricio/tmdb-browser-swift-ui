

import Foundation

struct Movie: Decodable, Hashable {
    var title: String?
    var adult: Bool?
    var backdrop_path: String?
    //    var belongs_to_collection: [Collection]?
    var budget: Int?
    var genres: [Genre]?
    var production_companies: [ProductionCompany]?
    var homepage: String?
    var id: Int?
    var imdb_id: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var revenue: Int?
    var status: String?
    var release_date: String?
    var tagline: String?
    var runtime: Int?
    
    init(id: Int) {
        self.id = id
        
        print("Constructor for movie called with id: \(id).")
        
        if id == 0 { return }
        
        guard let url = URL(string: entryPointUrl + "/movie/" + String(id) + "?api_key=" + apiKey) else {
            print("Problem creating URL")
            return
        }
        
        do {
            let response = try Data(contentsOf: url)
            self = try JSONDecoder().decode(Movie.self, from: response)
            print("Movie object created with id: \(id).")

        } catch {
            print(error)
            self.id = -1
        }
    }
}
