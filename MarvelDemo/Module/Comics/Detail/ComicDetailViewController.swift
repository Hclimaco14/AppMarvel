//
//  ComicDetailViewController.swift
//  MarvelDemo
//
//  Created by Hector Climaco on 10/07/22.
//  
//

import UIKit

protocol ComicDetailDisplayLogic {
    func displayDetail(detail: ComicDetail.ViewModel)
}

class ComicDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    
    // MARK: - Variables
    
    var interactor: ComicDetailBusinessLogic?
    var router: ComicDetailRoutingLogic?
    
    // MARK: - Object Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.getComic(request: ComicDetail.Request(idComic: 331))
    }
    
    // MARK: - Configurators
    
    fileprivate func setup() {
        
        let viewcontroller   = self
        let interactor      = ComicDetailInteractor()
        let presenter       = ComicDetailPresenter()
        let router          = ComicDetailRouter()
        
        viewcontroller.interactor = interactor
        viewcontroller.router     = router
        interactor.presenter      = presenter
        presenter.view            = viewcontroller
        router.view               = viewcontroller
    }
    
    // MARK: - Private
    
    
    // MARK: - Actions
    
    
}

extension ComicDetailViewController: ComicDetailDisplayLogic {
    func displayDetail(detail: ComicDetail.ViewModel) {
        
    }
}
