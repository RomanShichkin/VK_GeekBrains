//
//  PhotosCollectionViewCell.swift
//  VK_GeekBrains
//
//  Created by Роман Шичкин on 09.08.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var photoImage: WebImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    
    var isLiked = true
    var savedImage: UIImage?
    
    func clearCell() {
        photoImage.image = nil
        savedImage = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    func configure(userPhotos: PhotoItem) {
        
        guard let url = URL(string: userPhotos.srcBIG) else { return }
        let session = URLSession.shared

        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let _ = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.photoImage.setImage(at: url)
                }
            }
        }.resume()
        likeLabel.text = String(userPhotos.likes.count)
    }

    @IBAction func pressLikeButton(_ sender: Any) {
        if isLiked {
            likeLabel.pushTransition(0.4)
//            likeLabel.text = "1"
            likeLabel.textColor = UIColor.red
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = UIColor.red
        } else {
            likeLabel.pushTransition(0.4)
//            likeLabel.text = "0"
            likeLabel.textColor = UIColor.black
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = UIColor.black
        }
        isLiked = !isLiked
    }
    

}
