//
//  CryptosViewController.swift
//  BestCrypto
//
//  Created by Muharrem Köroğlu on 29.01.2023.
//

import UIKit
import SDWebImage

class CryptosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    private var rateListViewModel : RateListViewModel!
    private var assetListViewModel : CryptoAssetListViewModel!
    
    let searchBar = UISearchBar()
    
    var singleton = CryptoSingleton.sharedCryptoInfo
    
    var datas  = [Rates]()
    var filteredData = [Rates]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        searchBar.frame = CGRect(x: 0, y: 65, width: view.frame.width, height: 50)
        searchBar.showsCancelButton = true
        view.addSubview(searchBar)

        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        getRates()
        getAssets()
        

    }

    
    func getRates () {
        let url = URL(string: "https://rest.coinapi.io/v1/exchangerate/USD?apikey=8EF9CA70-B789-4259-882B-3A520D85DBD5&invert=true")!
        
        RatesWebService().getAllRates(url: url) { models in
            if let rates = models {
                self.rateListViewModel = RateListViewModel(cryptoRateList: rates.rates)
                self.datas = rates.rates
                self.filteredData = self.datas
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        singleton.cryptoName = ""
        filteredData = datas
        searchBar.endEditing(true)
        self.tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        filteredData.removeAll()
        
        if searchText == "" {
            filteredData = datas
            singleton.cryptoName = ""
        }else {
            for data in datas {
                if data.asset_id_quote.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(data)
                }
            }
        }
        self.tableView.reloadData()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.coinName.text = self.filteredData[indexPath.row].asset_id_quote
        cell.coinPrice.text = "$\(String(format: "%.3f", self.filteredData[indexPath.row].rate))"
        let iconUrl = assetListViewModel.iconURL(for: filteredData[indexPath.row].asset_id_quote)
        cell.coinAsset.sd_setImage(with: URL(string: "\(iconUrl)"))
        return cell
    }
}
