//
//  ComicHomePresenter.swift
//  MarvelDemo
//
//  Created by Hector Climaco on 10/07/22.
//  
//

import UIKit

protocol ComicHomePresentationLogic {
    func presentComics(response: ComicHome.Response.Comics)
    func presentFailure(error: RequestError)
}

class ComicHomePresenter: ComicHomePresentationLogic {
    
    var view: ComicHomeDisplayLogic?
    
    func presentComics(response: ComicHome.Response.Comics) {
        let comicsViewModel = ComicHome.ViewModel.Comics(response: response)
        view?.displayComics(response: comicsViewModel)
    }
    
    func presentFailure(error: RequestError) {
        let errorStr = "\(error.statusCode) \(error.description)"
        view?.displayFailure(error: errorStr)
    }
    
}
