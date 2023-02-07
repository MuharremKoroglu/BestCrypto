//
//  AssetWebService.swift
//  BestCrypto
//
//  Created by Muharrem Köroğlu on 30.01.2023.
//

import Foundation

class AssetWebService {
    
    func getCryptoAsset (url: URL, completion : @escaping([CryptoAssetModel]?) -> ()) {
    
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Something went wrong")
                completion(nil)
            }else if let data = data {
                let assets = try? JSONDecoder().decode([CryptoAssetModel].self, from: data)
                if let asset = assets {
                    completion(asset)
                }
            }
        }.resume()
        
    }
}
