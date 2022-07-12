//
//  ComicHomeCell.swift
//  MarvelDemo
//
//  Created by Hector Climaco on 12/07/22.
//

import UIKit

class ComicHomeCell: UITableViewCell {
    
    public static let identifier = "ComicHomeCell"
    
    var frontpageImgView: UIImageView = {
        let imagView = UIImageView()
        imagView.translatesAutoresizingMaskIntoConstraints = false
        imagView.contentMode = .scaleAspectFill
        imagView.clipsToBounds = true
        return imagView
    }()
    
    var titleLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .light)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var item =  ComicHome.ViewModel.Comics.ComicItem()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
        self.setupContrain()
        self.setData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupView()
        self.setupContrain()
        self.setData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        self.contentView.backgroundColor = .darkGray
        self.contentView.addSubview(frontpageImgView)
        self.contentView.addSubview(titleLbl)
        self.contentView.addSubview(descriptionLbl)
    }
    
    func setupContrain(){
        NSLayoutConstraint.activate([
            frontpageImgView.heightAnchor.constraint(equalToConstant: (spaceUnit.one * 5)),
            frontpageImgView.widthAnchor.constraint(equalTo: frontpageImgView.heightAnchor, multiplier: 0.666),
            frontpageImgView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: spaceUnit.half),
            frontpageImgView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: spaceUnit.half),
            frontpageImgView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -spaceUnit.half),

            descriptionLbl.leftAnchor.constraint(equalTo: frontpageImgView.rightAnchor, constant: spaceUnit.half),
            descriptionLbl.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -spaceUnit.half),
            descriptionLbl.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: spaceUnit.half),
            
            titleLbl.leftAnchor.constraint(equalTo: frontpageImgView.rightAnchor, constant: spaceUnit.half),
            titleLbl.bottomAnchor.constraint(equalTo: descriptionLbl.topAnchor, constant: -spaceUnit.half),
            titleLbl.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: spaceUnit.half),
            
        ])
    }
    
    public func setData() {
        if let title = self.item.title {
            self.titleLbl.text = title
        }
        
        if let descrip = self.item.resultDescription {
            self.descriptionLbl.text = descrip
        }
        
        if let imageURL =  self.item.thumbnail  {
            self.frontpageImgView.loadImageUsingCache(withUrl: imageURL)
        }
    }

}
