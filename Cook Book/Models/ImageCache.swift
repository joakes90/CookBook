//
//  ImageCache.swift
//  Cook Book
//
//  Created by Justin Oakes on 1/29/25.
//

import Foundation
import SwiftData

@Model
class ImageCache {
    var url: URL
    var data: Data
    var timestamp: Date
    
    init(url: URL, data: Data) {
        self.url = url
        self.data = data
        self.timestamp = Date()
    }
}
