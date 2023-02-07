//
//  CryptoModel.swift
//  BestCrypto
//
//  Created by Muharrem Köroğlu on 30.01.2023.
//

import Foundation

struct CryptoModel : Decodable{
    let rates : [Rates]
}

struct Rates : Decodable {
    let asset_id_quote : String
    let rate : Double
}
