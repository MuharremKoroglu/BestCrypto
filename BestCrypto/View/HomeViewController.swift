//
//  ViewController.swift
//  BestCrypto
//
//  Created by Muharrem Köroğlu on 29.01.2023.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var singleRateList : SingleRateViewModel!
    private var assetListViewModel : CryptoAssetListViewModel!
    
    var singleton = CryptoSingleton.sharedCryptoInfo
    var singleRateArray = [SingleCryptoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        getAssets()
    }
    
    func getData () {
        
        let url = URL(string: "https://rest.coinapi.io/v1/exchangerate/\(singleton.cryptoName)/USD?apikey=8EF9CA70-B789-4259-882B-3A520D85DBD5")!
        
        SingleRateService().getSpecificRate(url: url) { model in
            if let rates = model {
                self.singleRateArray.append(rates)
                self.singleton.cryptoName = ""
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
    }
    func getAssets () {
        let url = URL(string: "https://rest.coinapi.io/v1/assets/icons/64?apikey=8EF9CA70-B789-4259-882B-3A520D85DBD5")
        
        AssetWebService().getCryptoAsset(url: url!) { models in
            if let assets = models {
                self.assetListViewModel = CryptoAssetListViewModel(cryptoAssetList: assets)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        singleRateArray.remove(at: indexPath.item)
        collectionView.deleteItems(at: [indexPath])
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return singleRateArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.cryptoNameLabel.text = self.singleRateArray[indexPath.row].asset_id_base
        cell.cryptoPriceLabel.text = "$\(String(format: "%.3f", self.singleRateArray[indexPath.row].rate))"
        let iconUrl = self.assetListViewModel.iconURL(for: self.singleRateArray[indexPath.row].asset_id_base)
        cell.cryptoAsset.sd_setImage(with: URL(string: "\(iconUrl)"))
        return cell
    }

}
 
