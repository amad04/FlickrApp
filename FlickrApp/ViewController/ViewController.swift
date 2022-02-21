//
//  ViewController.swift
//  FlickrApp
//
//  Created by Amad WALID on 2022-02-19.
//

import UIKit

class ViewController: UIViewController {

    let cellIdentifier = "CELL"

    let animationDuration: Double = 1.0
    let delayBase: Double = 0.1

    let searchbar: UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset.left = 16
        cv.contentInset.right = 16
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        cv.backgroundColor = .white
        return cv
    }()

    var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.style = .large
        return spinner
    }()

    var detailVC = DetailViewController()
    var flickerManager = FlickrManager()

    var photoArray = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        flickerManager.flickrDelgate = self
        searchbar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self

        setupViews()
    }

    // MARK: - setupViews/Constrains
    func setupViews() {
        view.addSubview(searchbar)
        view.addSubview(collectionView)
        view.addSubview(spinner)
        setupConstrains()
    }
    
    func setupConstrains() {
        searchbar.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        searchbar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        searchbar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: searchbar.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func createImageURl(serverID: String, photoId: String, secret: String) -> String {
        let imgUrl = "https://live.staticflickr.com/\(serverID)/\(photoId)_\(secret)_s.jpg"
        return imgUrl
    }
}

// MARK: - UISearchDelgate
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        searchBar.resignFirstResponder()
        if let searchbarText = searchBar.text {
            
            DispatchQueue.main.async {
                self.spinner.startAnimating()
            }
            flickerManager.urlEncoder(with: searchbarText)
            searchBar.text = ""
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell else { return }

        let img = cell.imageView.image

        let selectedPhoto = self.photoArray[indexPath.row]

        detailVC.titleLabel.text = selectedPhoto.title
        detailVC.imageView.image = img

        present(detailVC, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell

        let photo = self.photoArray[indexPath.row]

        let imgUrl = createImageURl(serverID: photo.server, photoId: photo.id, secret: photo.secret)
        
        cell.configure(with: imgUrl)

        cell.alpha = 0
        return cell
    }

    // CollectionViewCell Animation
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        let column = Double(cell.frame.minX / cell.frame.width)
        let row = Double(cell.frame.minY / cell.frame.height)

        let distance = sqrt(pow(column, 2) + pow(row, 2))
        let delay = sqrt(distance) * delayBase


        UIView.animate(withDuration: animationDuration, delay: delay, options: [], animations: {
          cell.alpha = 1
        })
    }
}

// MARK: - FlickerMangerDelegate
extension ViewController: FlickerManagerDelegate {

    func didUpdateFlickr(array: [Photo]) {
        photoArray.removeAll()
        photoArray.append(contentsOf: array)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.spinner.stopAnimating()
        }
    }

    func didFailError(error: Error) {
        DispatchQueue.main.async {
            self.alert(message: error.localizedDescription)
            self.spinner.stopAnimating()
        }
    }

    func didFail(message: String) {
        DispatchQueue.main.async {
            self.alert(message: message)
            self.spinner.stopAnimating()
        }
    }

}
