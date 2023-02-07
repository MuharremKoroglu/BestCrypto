//
//  SingleRateViewModel.swift
//  BestCrypto
//
//  Created by Muharrem Köroğlu on 3.02.2023.
//

import Foundation

struct SingleRateViewModel {
    
    let singleRateList : SingleCryptoModel
    

    var cryptoName : String {
        return singleRateList.asset_id_base
    }
    
    var cryptoPrice : Double {
        return singleRateList.rate
    }
}
                          
