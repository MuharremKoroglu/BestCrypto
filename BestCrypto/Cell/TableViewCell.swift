//
//  TableViewCell.swift
//  BestCrypto
//
//  Created by Muharrem Köroğlu on 30.01.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var coinAsset: UIImageView!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var singleton = CryptoSingleton.sharedCryptoInfo
    
    override func awakeFromNib() {
        super.awakeFromNib()

        favouriteButton.addTarget(self, action: #selector(favouriteButtonClicked), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func favouriteButtonClicked () {
        singleton.cryptoName = coinName.text ?? "BTC"
    }
}
