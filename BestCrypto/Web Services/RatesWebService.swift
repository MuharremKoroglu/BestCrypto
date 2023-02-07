//
//  RatesWebService.swift
//  BestCrypto
//
//  Created by Muharrem Köroğlu on 30.01.2023.
//

import Foundation

class RatesWebService {
    
    func getAllRates (url : URL, completion : @escaping (CryptoModel?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Something went wrong")
                completion(nil)
            }else if let data = data{
                let rates = try? JSONDecoder().decode(CryptoModel.self, from: data)
                if let cryptoRates = rates {
                    completion(cryptoRates)
                }
            }
        }.resume()
    }
}

