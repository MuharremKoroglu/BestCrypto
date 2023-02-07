//
//  CryptoSingleton.swift
//  BestCrypto
//
//  Created by Muharrem Köroğlu on 3.02.2023.
//

import Foundation
import UIKit

class CryptoSingleton {
    
    static let sharedCryptoInfo = CryptoSingleton()
    
    var cryptoName = ""

    private init () {}
}
