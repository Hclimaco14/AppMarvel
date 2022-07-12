//
//  ComicHomeInteractor.swift
//  MarvelDemo
//
//  Created by Hector Climaco on 10/07/22.
//  
//


import Foundation


protocol ComicHomeBusinessLogic {
    func getComics()
}

class ComicHomeInteractor:  ComicHomeBusinessLogic {
    
    var presenter: ComicHomePresentationLogic?
    
    let worker = ComicHomeWorker()
    
    func getComics() {
        worker.getComics { result in
            switch result {
            case .success(let response):
                self.presenter?.presentComics(response: response)
                break
            case .failure(let error):
                self.presenter?.presentFailure(error: error)
                break
            }
        }
    }
    
}
