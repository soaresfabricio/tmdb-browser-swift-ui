import Foundation
import Combine

class MovieViewModel : ObservableObject {
    
    @Published var id: Int = 0
    @Published var movie: Movie = Movie(id: 0)
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var moviePublisher: AnyPublisher<Movie, Never> {
        $id
            .removeDuplicates()
            .map{
                Movie(id: $0)
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        moviePublisher
            .receive(on: DispatchQueue(label: "movies"))
            .assign(to: \.movie, on: self)
            .store(in: &cancellableSet)
    }
}
