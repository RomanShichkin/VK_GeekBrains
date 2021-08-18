//
//  FriendsViewController.swift
//  VK_GeekBrains
//
//  Created by Роман Шичкин on 08.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    let friendsTableViewCellReuse = "FriendsTableViewCell"
    let fromFriendsToPhotosSegue = "fromFriendsToPhotos"
    
    var service = NetworkService()
//    var friendsList = [FriendsItem]()
    let dateFormatter = DateFormatter()
    let queue = OperationQueue()
    
    private let friendsAdapter = VkAdapter()
    private var friendsList: [FriendsItem] = []
    
    private let friendFactory = FriendsViewModelFactory()
    private var viewModels: [FriendsViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "FriendsTableViewCell", bundle: nil), forCellReuseIdentifier: friendsTableViewCellReuse)
        service.getFriendsList() {[weak self] friendsList in
            guard let self = self else { return }
            self.friendsList = friendsList
            self.viewModels = self.friendFactory.constructViewModel(from: friendsList)
            self.tableView?.reloadData()
        }
//        friendsAdapter.adapterGetFriends(){ [weak self] friendsList in
//            self?.friendsList = friendsList
//            self?.tableView?.reloadData()
//        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friendsList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: friendsTableViewCellReuse, for: indexPath) as? FriendsTableViewCell else { return UITableViewCell() }

//        cell.configureWithUser(friends: friendsList[indexPath.row])
        cell.configureWithUser(friendsViewModel: viewModels[indexPath.row])
        // Configure the cell...

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
//
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//         return DataStorage.shared.userSections[section]
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromFriendsToPhotosSegue {
            guard let userId = sender as? String,
                  let destination = segue.destination as? PhotosCollectionViewController

            else {
                return
            }
            destination.userId = userId
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FriendsTableViewCell,
              let userId = cell.saveUserId
        else { return }
        
        performSegue(withIdentifier: fromFriendsToPhotosSegue, sender: userId)
    }
  
}
