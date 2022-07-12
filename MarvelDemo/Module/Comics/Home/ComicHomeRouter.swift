//
//  ComicHomeRouter.swift
//  MarvelDemo
//
//  Created by Hector Climaco on 10/07/22.
//  
//


import UIKit

protocol ComicHomeRoutingLogic {
    func goToDetail(item : ComicHome.ViewModel.Comics.ComicItem)
}

class ComicHomeRouter: ComicHomeRoutingLogic {
    var view: ComicHomeViewController?
    
    func goToDetail(item : ComicHome.ViewModel.Comics.ComicItem) {
        let vc  = ComicDetailViewController()
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
}
