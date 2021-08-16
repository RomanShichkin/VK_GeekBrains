//
//  FriendsTableViewCell.swift
//  VK_GeekBrains
//
//  Created by Роман Шичкин on 08.08.2021.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    var saveUserId: String?
//    var saveGroup: Group?
//    тест
    
    static let dateFormatter: DateFormatter = {
           let df = DateFormatter()
           df.dateFormat = "dd.MM.yyyy HH.mm"
           return df
       }()
    
    @IBInspectable var myShadowColor: UIColor = UIColor.black
    @IBInspectable var myShadowRadius: CGFloat = 10
    @IBInspectable var myShadowOpacity: Float = 0.9
    
    func clearCell() {
        mainImageView.image = nil
        nameLabel.text = nil
        descriptionLabel.text = nil
        saveUserId = ""
//        saveGroup = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        imageAnimate(imageView: mainImageView)
        // Configure the view for the selected state
    }
    
    func configureWithUser(friends: FriendsItem) {
        guard let url = URL(string: friends.photo100) else { return }
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let _ = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.mainImageView.setImage(at: url)
//                    self.mainImageView.image = image
                }
            }
        }.resume()
        
        
        
        if friends.bdate != nil {
            self.descriptionLabel.text =  "ДР: " + friends.bdate!
        } else {
            self.descriptionLabel.text = "Дата рождения не указана"
        }

//        descriptionLabel.text =  "ДР: " + friends.bdate
        nameLabel.text = friends.firstName + " " + friends.lastName
        
        shadowView.clipsToBounds = false
        shadowView.backgroundColor = UIColor.darkGray
        shadowView.layer.cornerRadius = mainImageView.frame.size.width / 2.0
        shadowView.layer.shadowColor = myShadowColor.cgColor
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = myShadowRadius
        shadowView.layer.shadowOpacity = myShadowOpacity

        mainImageView.layer.cornerRadius = mainImageView.frame.size.width / 2.0
        
        mainImageView.layer.shadowOffset = CGSize.zero
        mainImageView.layer.shadowRadius = 60
        mainImageView.layer.shadowOpacity = 2

        saveUserId = String(friends.id)
    }
    
    func configureWithGroup(groups: GroupItem) {
        guard let url = URL(string: groups.photo100) else { return }
        let session = URLSession.shared

        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let _ = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.mainImageView.setImage(at: url)
//                    self.mainImageView.image = image
                }
            }
        }.resume()

        nameLabel.text = groups.name
        descriptionLabel.text = "Адрес: " + groups.screenName
        
        shadowView.clipsToBounds = false
        shadowView.backgroundColor = UIColor.darkGray
        shadowView.layer.cornerRadius = mainImageView.frame.size.width / 2.0
        shadowView.layer.shadowColor = myShadowColor.cgColor
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = myShadowRadius
        shadowView.layer.shadowOpacity = myShadowOpacity

        mainImageView.layer.cornerRadius = mainImageView.frame.size.width / 2.0
        
        mainImageView.layer.shadowOffset = CGSize.zero
        mainImageView.layer.shadowRadius = 60
        mainImageView.layer.shadowOpacity = 2
        
    }
    
}

