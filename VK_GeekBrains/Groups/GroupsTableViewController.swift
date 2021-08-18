//
//  GroupsTableViewController.swift
//  VK_GeekBrains
//
//  Created by Роман Шичкин on 08.08.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    let friendsTableViewCellReuse = "FriendsTableViewCell"
    var service = NetworkService()
    var groupsList = [GroupItem]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "FriendsTableViewCell", bundle: nil), forCellReuseIdentifier: friendsTableViewCellReuse)
        getData()
    }
    
    private func getData() {
        service.getGroups() {[weak self] groupsList in
            self?.groupsList = groupsList
            self?.tableView?.reloadData()
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groupsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: friendsTableViewCellReuse, for: indexPath) as? FriendsTableViewCell else { return UITableViewCell() }
        
        cell.configureWithGroup(groups: groupsList[indexPath.row])
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        DataStorage.shared.myGroups.remove(at: indexPath.row)
//        self.tableView.reloadData()
//    }
//

}
