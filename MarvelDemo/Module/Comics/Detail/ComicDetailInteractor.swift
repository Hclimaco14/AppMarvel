//
//  ComicDetailInteractor.swift
//  MarvelDemo
//
//  Created by Hector Climaco on 10/07/22.
//  
//


import Foundation


protocol ComicDetailBusinessLogic {
    func getComic(request: ComicDetail.Request)
}

class ComicDetailInteractor:  ComicDetailBusinessLogic {
    
    var presenter: ComicDetailPresentationLogic?
    
    let worker = ComicDetailWorker()
    
    func getComic(request: ComicDetail.Request) {
        
        worker.getComic(request: request) { result in
            switch result {
            case .success(let response):
                self.presenter?.presentDetail(detail: response)
                break
            case .failure(let error):
                self.presenter?.presentFailure(error: error)
                break
            }

        }
    }
    
}
