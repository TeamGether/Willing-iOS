//
//  SelectGenreVC.swift
//  Willing
//
//  Created by Kim on 2021/05/14.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit

protocol SendGenreDataDelegate {
    func sendGenreData(data: String)
}

class SelectGenreVC: UIViewController {
    
    var delegate: SendGenreDataDelegate?
    
    @IBOutlet weak var genreListTableView: UITableView!
    let genreList = ["건강", "공부", "기타"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genreListTableView.delegate = self
        genreListTableView.dataSource = self
        registGenreListCell()
    }
    
    func registGenreListCell() {
        let nibName = UINib(nibName: "GenreTableViewCell", bundle: nil)
        genreListTableView.register(nibName, forCellReuseIdentifier: "GenreListCell")
    }
    
}

extension SelectGenreVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = genreListTableView.dequeueReusableCell(withIdentifier: "GenreListCell", for: indexPath) as! GenreTableViewCell
        
        cell.genreNameLabel.text = genreList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hey", indexPath.row)
        delegate?.sendGenreData(data: genreList[indexPath.row])
        self.dismiss(animated: false, completion: nil)
    }
    
}
