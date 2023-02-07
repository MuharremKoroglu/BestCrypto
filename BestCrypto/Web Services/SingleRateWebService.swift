//
//  SingleRateWebService.swift
//  BestCrypto
//
//  Created by Muharrem Köroğlu on 30.01.2023.
//

import Foundation

class SingleRateService {
    
    func getSpecificRate (url : URL, completion : @escaping(SingleCryptoModel?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Something went wrong")
                completion(nil)
            }else if let data = data {
                let rate = try? JSONDecoder().decode(SingleCryptoModel.self, from: data)
                if let specificRate = rate {
                    completion(specificRate)
                }
            }
            
        }.resume()
    }
}
