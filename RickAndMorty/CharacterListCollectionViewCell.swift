//
//  CharacterListCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import UIKit
import SDWebImage

class CharacterListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
    }
    
    func set(viewModel: CharacterList.Character) {
        imageView.sd_setImage(with: URL(string: viewModel.image), completed: nil)
        setFavoriteImageView(isFavorite: viewModel.isFavorite)
        nameLabel.text = viewModel.name
        statusLabel.text = viewModel.status
        speciesLabel.text = viewModel.species
    }
    
    private func setFavoriteImageView(isFavorite: Bool) {
        let named = isFavorite ? "star.fill" : "star"
        favoriteImageView.image = UIImage(systemName: named)
    }
}
