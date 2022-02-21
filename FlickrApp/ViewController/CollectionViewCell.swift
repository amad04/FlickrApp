//
//  CollectionViewCell.swift
//  FlickrApp
//
//  Created by Amad WALID on 2022-02-19.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 5
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(imageView)
        
        setupConstrains()
    }
    
    func setupConstrains() {
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    }
    
    func configure(with urlString: String) {
        var image: UIImage?
        guard let url = URL(string: urlString) else{
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in

            guard let data = data , error == nil else {
                print("Kunde inte läsa bilden")
                return
            }
            DispatchQueue.main.async {
                image = UIImage(data: data)
                self.imageView.image = image
            }
        }.resume()
    }
}
