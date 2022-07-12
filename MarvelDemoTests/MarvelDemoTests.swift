//
//  MarvelDemoTests.swift
//  MarvelDemoTests
//
//  Created by Hector Climaco on 11/07/22.
//

import XCTest
@testable import MarvelDemo

class MarvelDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testComicsResponse() {
        
        let worker = ComicHomeWorker(serviceManager: MockServiceManager(nameFile: "getComics"))
        
        worker.getComics { result in
            switch result {
            case .success(let response):
                XCTAssert(true, "Test for worker succes \(response)")
                break
            case .failure(let error):
                
                XCTAssert(false, "Test for worker fail \(error.description)")
                break
            }
        }
        
    }
    
    func testComicsById() {
        
        let request =  ComicDetail.Request(idComic: 3)
        let worker = ComicDetailWorker(serviceManager: MockServiceManager(nameFile: "findComicID"))
        
        worker.getComic(request: request) { result in
            switch result {
            case .success(let response):
                XCTAssert(true, "Test for worker succes \(response)")
                break
            case .failure(let error):
                
                XCTAssert(false, "Test for worker fail \(error.description)")
                break
            }
        }
    }

}
