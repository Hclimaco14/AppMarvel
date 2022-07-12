//
//  ComicDetailModels.swift
//  MarvelDemo
//
//  Created by Hector Climaco on 10/07/22.
//  
//

import UIKit

enum ComicDetail {
    
    struct Request {
        var idComic: Int
    }
    struct Response {
        
        // MARK: - ComicDetail
        struct ComicDetail: Codable {
            var code: Int?
            var status, copyright, attributionText, attributionHTML: String?
            var etag: String?
            var data: DataClass?
        }
        
        // MARK: - DataClass
        struct DataClass: Codable {
            var offset, limit, total, count: Int?
            var results: [Result]?
        }
        
        // MARK: - Result
        struct Result: Codable {
            var id, digitalID: Int?
            var title: String?
            var issueNumber: Int?
            var variantDescription, resultDescription, modified, isbn: String?
            var upc, diamondCode, ean, issn: String?
            var format: String?
            var pageCount: Int?
            var textObjects: [TextObject]?
            var resourceURI: String?
            var urls: [URLElement]?
            var series: Series?
            var dates: [DateElement]?
            var prices: [Price]?
            var thumbnail: Thumbnail?
            var images: [Thumbnail]?
            var creators, characters, stories, events: Characters?
            
            enum CodingKeys: String, CodingKey {
                case id
                case digitalID = "digitalId"
                case title, issueNumber, variantDescription
                case resultDescription = "description"
                case modified, isbn, upc, diamondCode, ean, issn, format, pageCount, textObjects, resourceURI, urls, series, dates, prices, thumbnail, images, creators, characters, stories, events
            }
        }
        
        // MARK: - Characters
        struct Characters: Codable {
            var available: Int?
            var collectionURI: String?
            var returned: Int?
            var items: [Item]?
        }
        
        // MARK: - Item
        struct Item: Codable {
            var resourceURI: String?
            var name, type: String?
        }
        
        // MARK: - DateElement
        struct DateElement: Codable {
            var type, date: String?
        }
        
        // MARK: - Thumbnail
        struct Thumbnail: Codable {
            var path: String?
            var thumbnailExtension: String?
            
            enum CodingKeys: String, CodingKey {
                case path
                case thumbnailExtension = "extension"
            }
        }
        
        // MARK: - Price
        struct Price: Codable {
            var type: String?
            var price: Double?
        }
        
        // MARK: - Series
        struct Series: Codable {
            var resourceURI: String?
            var name: String?
        }
        
        // MARK: - TextObject
        struct TextObject: Codable {
            var type, language, text: String?
        }
        
        // MARK: - URLElement
        struct URLElement: Codable {
            var type: String?
            var url: String?
        }
        
    }
    struct ViewModel {
        
    }
    
    
}
