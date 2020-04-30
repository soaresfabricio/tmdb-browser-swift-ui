import Foundation
import SwiftUI

enum BackdropQuality {
    case Highest
    case High
    case Medium
    case Low
}

enum PosterQuality {
    case w92
    case w154
    case w185
    case w342
    case w500
    case w780
    case original
}

func getBackdropUrl(quality: BackdropQuality, path: String) -> URL {
    
    var url = URL(string: imagesEntryPoint)!

    switch quality {
        case .Highest:
            url.appendPathComponent("original/")
        case .High:
            url.appendPathComponent("w1280/")
        case .Medium:
            url.appendPathComponent("w780/")
        case .Low:
            url.appendPathComponent("w300/")
    }
    
    url.appendPathComponent(path)
    
    return url
    
}

func getPosterUrl(quality : PosterQuality,  path: String) -> URL {
    
    var url = URL(string: imagesEntryPoint)!
    

    switch quality {
        case .w92:
            url.appendPathComponent("w92/")
        case .w154:
            url.appendPathComponent("w154/")
        case .w185:
            url.appendPathComponent("w185/")
        case .w342:
            url.appendPathComponent("w342/")
        case .w500:
            url.appendPathComponent("w500/")
        case .w780:
            url.appendPathComponent("w780/")
        case .original:
            url.appendPathComponent("original/")
    }
    
    url.appendPathComponent(path)
    
    
    return url
    
}
