//
//  ComicDetailPresenter.swift
//  MarvelDemo
//
//  Created by Hector Climaco on 10/07/22.
//  
//

import UIKit

protocol ComicDetailPresentationLogic {
    func presentDetail(detail: ComicDetail.Response.ComicDetail)
    func presentFailure(error: RequestError)
}

class ComicDetailPresenter: ComicDetailPresentationLogic {
    
    var view: ComicDetailDisplayLogic?
    
    func presentDetail(detail: ComicDetail.Response.ComicDetail) {
        view?.displayDetail(detail: ComicDetail.ViewModel.ComicDetailViewModel(response: detail))
    }
    
    func presentFailure(error: RequestError) {
        
    }
}
