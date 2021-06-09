//
//  FriendsViewController.swift
//  Willing
//
//  Created by Kim on 2021/04/08.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    @IBOutlet weak var friendsTableView: UITableView!
    var friendsList = [""] {
        didSet {
            friendsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        registCell()
        
        guard let email = user?.email else { return }
        getFriendsList(email: email)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func registCell() {
        let nibName = UINib(nibName: "FriendsTableViewCell", bundle: nil)
        friendsTableView.register(nibName, forCellReuseIdentifier: "FriendCell")
    }

    func getFriendsList(email: String) {
        DBNetwork.getFriends(email: email) {
            follows in
            let follower : Set = Set(follows.follower)
            let following : Set = Set(follows.following)
            let friends: Array<String> = Array((follower.intersection(following)).sorted())
            self.friendsList = friends
        }
    }

}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendsTableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendsTableViewCell
        let name = friendsList[indexPath.row]
        cell.cheerView.layer.cornerRadius = 5
        cell.userImgView.layer.cornerRadius = 20
        
        cell.nameLabel.text = name
        DBNetwork.getUserByName(name: name) { userData in
            print(userData)
            cell.emailLabel.text = userData.email
            guard userData.profileImg != nil else { return }
            DBNetwork.getImage(url: userData.profileImg!) { image in
                cell.userImgView.image = image
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MyPageViewContoller()
        
        guard let email = (friendsTableView.cellForRow(at: indexPath) as! FriendsTableViewCell).emailLabel.text else { return }
        vc.userEmail = email
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

