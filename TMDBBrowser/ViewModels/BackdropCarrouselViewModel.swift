import Foundation

class BackdropCarrouselViewModel : ObservableObject {
    @Published var carrousel : BackdropCarroussel
    
    init(type: CarrouselType){
        carrousel = BackdropCarroussel(type: type)
    }
    
}
