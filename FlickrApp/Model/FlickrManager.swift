//
//  FlickrManager.swift
//  FlickrApp
//
//  Created by Amad WALID on 2022-02-19.
//

import Foundation

protocol FlickerManagerDelegate {
    func didUpdateFlickr(array: [Photo])
    func didFail(message: String)
    func didFailError(error: Error)
}

struct FlickrManager {

    var flickrDelgate: FlickerManagerDelegate?

    func urlEncoder(with searchedText: String) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "flickr.com"
        components.path = "/services/rest"
        components.queryItems = [
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "api_key", value: "44db8b788ff280f7e082c8ac5a71ebe5"),
            URLQueryItem(name: "text", value: "\(searchedText)"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
        ]

        guard let urlString = components.url else {
            return
        }

        performRequest(with: urlString)
    }

    func performRequest(with urlString: URL) {

        let url = urlString

        let urlSession = URLSession(configuration: .default)

        let task = urlSession.dataTask(with: url) { (data, response, error) in

            if let error = error {
                flickrDelgate?.didFailError(error: error)
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                    flickrDelgate?.didFail(message: "fel, kunde inte ladda sidan")
                      return
                  }

            if let safeImageData = data {
                parseSearchedResualt(with: safeImageData)
            }
        }
        task.resume()
    }

    func parseSearchedResualt(with imageData: Data) {

        let decoder = JSONDecoder()

        do {
            let decodeData = try decoder.decode(FlickrData.self, from: imageData)
            self.flickrDelgate?.didUpdateFlickr(array: decodeData.photos.photo)
        }

        catch {
            flickrDelgate?.didFailError(error: error)
        }
    }
}
