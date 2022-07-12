//
//  ComicDetailRouter.swift
//  MarvelDemo
//
//  Created by Hector Climaco on 10/07/22.
//  
//


import UIKit

protocol ComicDetailRoutingLogic {
    func backToHome()
}

class ComicDetailRouter: ComicDetailRoutingLogic {
    
    var view: ComicDetailViewController?
    
    func backToHome() {
        self.view?.navigationController?.popViewController(animated: true)
    }
    
}
