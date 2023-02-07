//
//  CryptoAssetViewModel.swift
//  BestCrypto
//
//  Created by Muharrem Köroğlu on 1.02.2023.
//

import Foundation

struct CryptoAssetListViewModel {
    
    let cryptoAssetList : [CryptoAssetModel]
    
    func iconURL (for asset_id_quote : String) -> String {
        for asset in cryptoAssetList {
            if asset.asset_id == asset_id_quote {
                return asset.url
            }
        }
        return "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_64/0a4185f21a034a7cb866ba7076d8c73b.png"
    }
}

struct CryptoAssetViewModel {
    
    let cryptoAsset : CryptoAssetModel
    let rateConnection : RateViewModel
    
    var assetName : String {
        return cryptoAsset.asset_id
    }
    
    var assetUrl : String {
        return cryptoAsset.url
    }
}
