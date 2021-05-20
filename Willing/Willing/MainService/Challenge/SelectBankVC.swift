//
//  SelectBankVC.swift
//  Willing
//
//  Created by Kim on 2021/05/15.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit
protocol SendBankDataDelegate {
    func sendBankData(data: String)
}

class SelectBankVC: UIViewController {
    
    var delegate: SendBankDataDelegate?
    
    @IBOutlet weak var bankListTableView: UITableView!
    var bankList = ["우리은행", "농협은행", "신한은행", "시티은행", "카카오뱅크"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bankListTableView.delegate = self
        bankListTableView.dataSource = self
        registBankListCell()
    }
    
    func registBankListCell() {
        let nibName = UINib(nibName: "SelectBankTableViewCell", bundle: nil)
        bankListTableView.register(nibName, forCellReuseIdentifier: "BankListCell")
    }

}

extension SelectBankVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bankListTableView.dequeueReusableCell(withIdentifier: "BankListCell", for: indexPath) as! SelectBankTableViewCell
        
        cell.bankNameLabel!.text = bankList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hey", indexPath.row)
        delegate?.sendBankData(data: bankList[indexPath.row])
        self.dismiss(animated: false, completion: nil)
    }
    
    
}
