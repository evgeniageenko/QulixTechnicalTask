//
//  CoinData.swift
//  Quilix Technical Task
//
//  Created by Евгений Агеенко on 22.07.22.
//

import Foundation

struct CoinData: Codable {
    let asset_id_base: String?
    let rates: [Rates]?
}

struct Rates: Codable {
    let time: String?
    let asset_id_quote: String?
    let rate: Double?
}
