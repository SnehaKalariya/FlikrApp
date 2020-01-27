//
//  MostInterestingPhotoModel.swift
//  FlickerApp
//
//  Created by Greek1 on 1/27/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

// MARK: - MostInterestingPhotoModel
struct MostInterestingPhotoModel: Codable {
    let photos: Photos1
    let stat: String
}

// MARK: - Photos
struct Photos1: Codable {
    let page, pages, perpage: Int
    let total: String
    let photo: [Photo1]
}

// MARK: - Photo
struct Photo1: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}

