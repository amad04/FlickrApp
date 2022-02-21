//
//  DetailedImageViewController.swift
//  FlickrApp
//
//  Created by Amad WALID on 2022-02-20.
//

import UIKit

class DetailViewController: UIViewController {

    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.backgroundColor = .white
        lbl.numberOfLines = 2
        lbl.layer.cornerRadius = 5
        lbl.clipsToBounds = true
        return lbl
    }()

    var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 5
        imgView.clipsToBounds = true
        imgView.backgroundColor = .blue
        return imgView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    func setupViews(){
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(imageView)

        setupConstrains()
    }
    
    func setupConstrains() {
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
}
