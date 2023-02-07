//
//  SingleCryptoModel.swift
//  BestCrypto
//
//  Created by Muharrem Köroğlu on 30.01.2023.
//

import Foundation

struct SingleCryptoModel : Decodable {
    let asset_id_base : String
    let rate : Double
}
