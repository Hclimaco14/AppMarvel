//
//  ComicHomeModels.swift
//  MarvelDemo
//
//  Created by Hector Climaco on 10/07/22.
//  
//

import UIKit
import Foundation

enum ComicHome {
    
    public struct Request {
        
    }
    
    public struct ViewModel {
        public struct Comics{
            var elements: [ComicItem] = []
            public init(response: Response.Comics){
                let comicsArray = response.data?.results?.compactMap({ comicItem in
                    ViewModel.Comics.ComicItem(title: comicItem.title, resultDescription: comicItem.resultDescription, thumbnail: thumbnailURL(thumbnail: comicItem.thumbnail), data: comicItem)
                })
                self.elements = comicsArray ?? []
            }
            
            public struct ComicItem {
                var title:String?
                var resultDescription: String?
                var thumbnail: String?
                var data: Response.Result
                
                public init(){
                    self.title = ""
                    self.resultDescription = ""
                    self.thumbnail = ""
                    self.data = Response.Result()
                }
                
                public init(title: String?, resultDescription: String?, thumbnail: String?, data:  Response.Result){
                    self.title = title
                    self.resultDescription = resultDescription
                    self.thumbnail = thumbnail
                    self.data = data
                }
                
            }
            
            func thumbnailURL(thumbnail: ComicHome.Response.Thumbnail?) -> String? {
                if let path = thumbnail?.path,let ext = thumbnail?.thumbnailExtension{
                    return path + "." + ext
                } else {
                    return nil
                }
            }
        }
    }
    
    public struct Response {
        
        // MARK: - Comics
        struct Comics: Codable {
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
            var variantDescription, resultDescription: String?
            var modified: String?
            var isbn, upc, diamondCode, ean: String?
            var issn, format: String?
            var pageCount: Int?
            var textObjects: [TextObject]?
            var resourceURI: String?
            var urls: [URLElement]?
            var series: Series?
            var variants, collectedIssues: [Series]?
            var dates: [DateElement]?
            var prices: [Price]?
            var thumbnail: Thumbnail?
            var images: [Thumbnail]?
            var creators: Creators?
            var characters, stories, events: Characters?
            
            enum CodingKeys: String, CodingKey {
                case id
                case digitalID = "digitalId"
                case title, issueNumber, variantDescription
                case resultDescription = "description"
                case modified, isbn, upc, diamondCode, ean, issn, format, pageCount, textObjects, resourceURI, urls, series, variants, collectedIssues, dates, prices, thumbnail, images, creators, characters, stories, events
            }
        }
        
        // MARK: - Characters
        struct Characters: Codable {
            var available: Int?
            var collectionURI: String?
            var items: [CharactersItem]?
            var returned: Int?
        }
        
        // MARK: - CharactersItem
        struct CharactersItem: Codable {
            var resourceURI: String?
            var name, type: String?
        }
        
        // MARK: - Series
        struct Series: Codable {
            var resourceURI: String?
            var name: String?
        }
        
        // MARK: - Creators
        struct Creators: Codable {
            var available: Int?
            var collectionURI: String?
            var items: [CreatorsItem]?
            var returned: Int?
        }
        
        // MARK: - CreatorsItem
        struct CreatorsItem: Codable {
            var resourceURI: String?
            var name, role: String?
        }
        
        // MARK: - DateElement
        struct DateElement: Codable {
            var type: String?
            var date: String?
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
    
}
