//
//  FeedViewController.swift
//  Willing
//
//  Created by Kim on 2021/04/08.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var recentBtn: UIButton!
    
    @IBOutlet weak var followUnderBarView: UIView!
    @IBOutlet weak var recentUnderBarView: UIView!
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    
    enum Mode: String {
        case follow
        case recent
    }
    var mode = Mode.follow {
        didSet {
            setTab()
            setFeedList()
        }
    }
    var feedList: Array<Certification> = [] {
        didSet {
            feedCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
        registCell()
        setTab()
    }
    
    func registCell() {
        self.feedCollectionView.register(UINib(nibName: "CertificationCollectionViewCell", bundle: nil) ,forCellWithReuseIdentifier: "CertificationCell")
    }

    func setTab() {
        switch mode {
        case .follow:
            followBtn.setTitleColor(UIColor(named: "PRIMARY BLUE"), for: .normal)
            recentBtn.setTitleColor(UIColor.black, for: .normal)
            followUnderBarView.isHidden = false
            recentUnderBarView.isHidden = true
            break
        case .recent:
            followBtn.setTitleColor(UIColor.black, for: .normal)
            recentBtn.setTitleColor(UIColor(named: "PRIMARY BLUE"), for: .normal)
            followUnderBarView.isHidden = true
            recentUnderBarView.isHidden = false
            break
        }
    }
    
    func setFeedList() {
        switch mode {
        case .follow:
//            var followingNameList: Array<String> = []
//            DBNetwork.getFriends(email: (user?.email)!) {
//                follows in
//                followingNameList = follows.following
//
//
//            }
            feedList = []
            break
        case .recent:
            DBNetwork.getRecentFeeds() {
                feedList in
                self.feedList = feedList
            }
            break
        }
    }
    
    @IBAction func followBtnClicked(_ sender: Any) {
        mode = .follow
    }
    
    @IBAction func recentBtnClicked(_ sender: Any) {
        mode = .recent
    }
    
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CertificationCell", for: indexPath) as! CertificationCollectionViewCell
        cell.layer.cornerRadius = 10
        DBNetwork.getImage(url: feedList[indexPath.row].Imgurl) { image in
            cell.certifiationImageView.image = image
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellwidth = (feedCollectionView.bounds.width - 6)/4
        let cellheight = cellwidth
        return CGSize(width: cellwidth, height: cellheight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(feedCollectionView.cellForItem(at: indexPath))
        print(feedList[indexPath.row])
    }
    
}
