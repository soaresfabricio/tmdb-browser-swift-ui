import Combine
import Foundation

struct SearchResult: Decodable, Hashable {
    var page: Int?
    var results: [Movie]?
    var total_results: Int?
    var total_pages: Int?
}

class SearchViewModel: ObservableObject {
    // input
    @Published var searchTerm: String = ""
    
    // output
    @Published var results = [Movie]()
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    func fetchResults(searchTerm: String, page: Int = 1) -> [Movie]? {
        let query = entryPointUrl + "/search/movie" + "?api_key=" + apiKey + "&query=" + searchTerm + "&page=\(page)"
        
        guard let url = URL(string: query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            else {
                print("wrong URL")
                return nil
        }

        do {
            let response = try Data(contentsOf: url)
            return try JSONDecoder().decode(SearchResult.self, from: response).results
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
        
    }
    
    private var searchResultPublisher: AnyPublisher<[Movie], Never> {
        return $searchTerm
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
                (self.fetchResults(searchTerm: $0) ?? [])
            }
            .eraseToAnyPublisher()
    }
    
    
    init() {
        searchResultPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.results, on: self)
            .store(in: &cancellableSet)
    }
}
