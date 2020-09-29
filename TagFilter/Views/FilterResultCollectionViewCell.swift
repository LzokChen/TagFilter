//
//  FilterResultCollectionViewCell.swift
//  TagFilter
//
//  Created by Xiaojian Chen on 9/27/20.
//

import UIKit

class FilterResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    static let identifier = "FilterResultCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func configure(with name: String){
        nameLabel.text = name
    }
    
    static func nib() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }

}
