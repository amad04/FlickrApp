//
//  FlickrData.swift
//  FlickrApp
//
//  Created by Amad WALID on 2022-02-19.
//

import Foundation

struct FlickrData: Codable {
    let photos: Photos
}

struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let photo: [Photo]
}

struct Photo: Codable {
    let id: String
    let secret: String
    let server: String
    let title: String
}
