//
//  DetailedImageViewController.swift
//  FlickrApp
//
//  Created by Amad WALID on 2022-02-20.
//

import UIKit

class DetailViewController: UIViewController {

    let stackView: UIStackView = {
         let sv = UIStackView()
         sv.translatesAutoresizingMaskIntoConstraints = false
         sv.axis = .vertical
         sv.alignment = .center
         sv.spacing = 20
         return sv
     }()

    let headerLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.backgroundColor = .white
        lbl.numberOfLines = 0
        lbl.text = "Photo with description"
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        return lbl
    }()


    let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 5
        imgView.clipsToBounds = true
        return imgView
    }()

    let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.backgroundColor = .white
        lbl.numberOfLines = 0
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews(){
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.addArrangedSubview(headerLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(descriptionLabel)

        setupConstrains()
    }

    func setupConstrains() {
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        stackView.setCustomSpacing(60, after: headerLabel)

        imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
}
