//
//  BannerCVCell.swift
//  FakeStoreDemo
//
//  Created by Adam Chen on 2025/7/26.
//

import UIKit

class BannerCVCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    static let identifier = "BannerCVCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
    }

}
