//
//  PhotoListingTableViewCell.swift
//  TemplateApp
//
//  Created by Muhammad Usman on 08/02/2021.
//

import UIKit

final class PhotoListingTableViewCell: UITableViewCell {
    //MARK:- private properties
    
    @IBOutlet private weak var albumLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var listImage: UIImageView!
    
    //MARK:- public methods
    
    func configure(with viewModel: PhotoRowViewModel) {
        albumLabel.text = viewModel.album
        titleLabel.text = viewModel.titleInfo
    }
}
