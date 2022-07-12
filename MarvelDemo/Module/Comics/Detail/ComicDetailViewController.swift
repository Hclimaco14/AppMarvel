//
//  ComicDetailViewController.swift
//  MarvelDemo
//
//  Created by Hector Climaco on 10/07/22.
//  
//

import UIKit

protocol ComicDetailDisplayLogic {
    func displayDetail(detail: ComicDetail.ViewModel.ComicDetailViewModel)
}

class ComicDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    var titleLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var backgroundImg: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    
    var publishedLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var publishedDescriptionLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var descriptionLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = spaceUnit.one
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var scrollViewContent: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .darkGray
        scrollView.addSubview(stackView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.indicatorStyle = .default
        return scrollView
    }()
    
    // MARK: - Variables
    
    var interactor: ComicDetailBusinessLogic?
    var router: ComicDetailRoutingLogic?
    var item = ComicHome.ViewModel.Comics.ComicItem()
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
        setupStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor?.getComic(request: ComicDetail.Request(idComic: item.data.id ?? 0))
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
    
    private func setupStackView() {
        view.backgroundColor = .darkGray
        view.addSubview(scrollViewContent)
        
        setupComponents()
        
        NSLayoutConstraint.activate([
        scrollViewContent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        scrollViewContent.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: spaceUnit.one),
        scrollViewContent.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -spaceUnit.one),
        scrollViewContent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollViewContent.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollViewContent.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollViewContent.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollViewContent.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollViewContent.widthAnchor),
           
            titleLbl.leadingAnchor.constraint(equalTo: scrollViewContent.leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: scrollViewContent.trailingAnchor),
            
            backgroundImg.widthAnchor.constraint(equalTo: scrollViewContent.widthAnchor),
            backgroundImg.heightAnchor.constraint(equalTo: scrollViewContent.widthAnchor, multiplier: 1.5),
        ])
        
    }
    
    
    func setupComponents() {
        self.stackView.addArrangedSubview(self.titleLbl)
        self.stackView.addArrangedSubview(self.backgroundImg)
        self.stackView.addArrangedSubview(self.publishedDescriptionLbl)
        self.stackView.addArrangedSubview(self.descriptionLbl)
        self.getButtonBack()
    }
    
    // MARK: - Actions
    
    func setTitle(titleStr: String) {
        DispatchQueue.main.async {
            self.titleLbl.isHidden = false
            self.titleLbl.text = titleStr
        }
    }
    
    func loadImage(imgStr: String ) {
        DispatchQueue.main.async {
            self.backgroundImg.isHidden = false
            self.backgroundImg.loadImageUsingCache(withUrl: imgStr)
        }
    }
    
    func setPublished(publishedStr: String) {
        DispatchQueue.main.async {
            self.publishedDescriptionLbl.isHidden = false
            self.publishedDescriptionLbl.text = publishedStr
        }
    }
    
    func setDescription(descriptionStr: String) {
        DispatchQueue.main.async {
            self.descriptionLbl.isHidden = false
            self.descriptionLbl.text = descriptionStr
        }
    }
    
    func getButtonBack() {
        let buttonBacki = UIButton(type: .custom)
        buttonBacki.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        buttonBacki.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let imgNormal = UIImage(named:"atras_gris")
        imgNormal?.withTintColor(.red)
        buttonBacki.setImage(imgNormal, for: UIControl.State())
        buttonBacki.imageEdgeInsets.left = -40.0
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: buttonBacki)
        self.navigationItem.setLeftBarButton(leftBarButtonItem, animated: false)
    }
    
    
    @objc func backButtonClick() {
        router?.backToHome()
    }
    
    
}

extension ComicDetailViewController: ComicDetailDisplayLogic {
    func displayDetail(detail: ComicDetail.ViewModel.ComicDetailViewModel) {
        if let titleStr = detail.title {
            self.setTitle(titleStr: titleStr)
        }
            
        if let imageStr = detail.thumbnail {
            self.loadImage(imgStr: imageStr)
        }
        
        if let published = detail.publisher {
            self.setPublished(publishedStr: published)
        }
        
        if let desc = detail.comicDescription {
            self.setDescription(descriptionStr: desc)
        }
    }
}
