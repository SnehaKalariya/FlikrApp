//
//  MostRecentPhotoModel.swift
//  FlickerApp
//
//  Created by Greek1 on 1/27/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

// MARK: - MostRecentPhotoModel
struct MostRecentPhotoModel: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage: Int
    let total: Int?
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}

