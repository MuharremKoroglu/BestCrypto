//
//  RatesViewModel.swift
//  BestCrypto
//
//  Created by Muharrem Köroğlu on 1.02.2023.
//

import Foundation

struct RateListViewModel {
    
    let cryptoRateList : [Rates]
    
}

struct RateViewModel {
    let cryptoRate : Rates
    
    var cryptoName : String {
        return cryptoRate.asset_id_quote
    }
    
    var cryptoPrice : Double {
        return cryptoRate.rate
    }
}
