//
//  PhotosCollectionViewController.swift
//  VK_GeekBrains
//
//  Created by Роман Шичкин on 09.08.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotosCollectionViewController: UICollectionViewController {
    
    let inset: CGFloat = 20
    let minimumLineSpacing: CGFloat = 20
    let minimumInteritemSpacing: CGFloat = 20
    let cellsPerRow = 2
    
    var service = NetworkService()
    var userPhotos = [PhotoItem]()
    var userId = ""
    
    let photosCollectionViewCellReuse = "PhotosCollectionViewCell"
    let openFriendFotoSegue = "openFriendPhoto"
    
    var fotoArray = [UIImage]()
    
    
    override func viewDidLoad() {
        print(userId)
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: photosCollectionViewCellReuse)
        service.getUserPhotos(userId: userId) {[weak self] userPhotos in
            self?.userPhotos = userPhotos
            self?.collectionView?.reloadData()
        }
        
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotosCollectionViewCell
//        //              let foto = cell.savedImage
//        else { return }
//        performSegue(withIdentifier: openFriendFotoSegue, sender: cell.savedImage)
//    }
    
    
    // MARK: UICollectionViewDataSource
    
    func findIndex(image searchImage: UIImage, in array: [UIImage]) -> Int? {
        for (index, image) in array.enumerated() {
            if image == searchImage {
                return index
            }
        }
     
        return nil
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return userPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photosCollectionViewCellReuse, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(userPhotos: userPhotos[indexPath.row])
        // Configure the cell
        
        return cell
    }
    

    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
