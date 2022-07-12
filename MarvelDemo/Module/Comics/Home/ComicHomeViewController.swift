//
//  ComicHomeViewController.swift
//  MarvelDemo
//
//  Created by Hector Climaco on 10/07/22.
//  
//

import UIKit

protocol ComicHomeDisplayLogic {
    func displayComics(response: ComicHome.ViewModel.Comics)
    func displayFailure(error: String)
}

class ComicHomeViewController: UIViewController {
    
    
    typealias ComicItem = ComicHome.ViewModel.Comics.ComicItem
    // MARK: - Outlets
    var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Variables
    
    var interactor: ComicHomeBusinessLogic?
    var router: ComicHomeRoutingLogic?
    var elements: [ComicItem] = []
    
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
        setupComponens()
        setContrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor?.getComics()
    }
    
    // MARK: - Configurators
    
    fileprivate func setup() {
        let viewcontroller   = self
        let interactor      = ComicHomeInteractor()
        let presenter       = ComicHomePresenter()
        let router          = ComicHomeRouter()
        
        viewcontroller.interactor = interactor
        viewcontroller.router     = router
        interactor.presenter      = presenter
        presenter.view            = viewcontroller
        router.view               = viewcontroller
    }
    
    // MARK: - Private
    
    fileprivate func setupComponens() {
        self.title = "Comics"
        self.view.addSubview(tableView)
        self.tableView.register(ComicHomeCell.self, forCellReuseIdentifier: ComicHomeCell.identifier)
        self.tableView.dataSource = self
        self.tableView.delegate   = self
        
    }
    
    fileprivate func setContrains() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: spaceUnit.one),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: spaceUnit.one),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -spaceUnit.one),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -spaceUnit.one)
        ])
    }
    
    // MARK: - Actions
    
}

extension ComicHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ComicHomeCell.identifier, for: indexPath) as? ComicHomeCell else {
            return UITableViewCell()
        }
        cell.item = elements [indexPath.row]
        cell.setData()
        return cell
    }
    
}


extension ComicHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.router?.goToDetail(item: elements[indexPath.row])
    }
}

extension ComicHomeViewController: ComicHomeDisplayLogic {
    func displayComics(response: ComicHome.ViewModel.Comics) {
        
        DispatchQueue.main.async {
            self.elements = response.elements
            self.tableView.reloadData()
        }
        print(response)
    }
    
    func displayFailure(error: String) {
        print(error)
    }
    
}
