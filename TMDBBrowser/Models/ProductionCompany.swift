//
//  ProductionCompan.swift
//  WeSplit
//
//  Created by Fabrício Soares on 26/04/20.
//  Copyright © 2020 Fabrício Soares. All rights reserved.
//

import Foundation

struct ProductionCompany: Decodable, Hashable {
    var id: Int?
    var logo_path: String?
    var name: String?
    var origin_country: String?
}
