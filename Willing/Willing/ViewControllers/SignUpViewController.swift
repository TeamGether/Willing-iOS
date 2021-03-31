//
//  SignUpViewController.swift
//  Willing
//
//  Created by Kim on 2021/03/30.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nicknameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var pwdTxtField: UITextField!
    @IBOutlet weak var pwdCheckTxtField: UITextField!
    @IBOutlet weak var donateNameTxtField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        setTxtFieldUI(txtField: nicknameTxtField)
        setTxtFieldUI(txtField: emailTxtField)
        setTxtFieldUI(txtField: pwdTxtField)
        setTxtFieldUI(txtField: pwdCheckTxtField)
        setTxtFieldUI(txtField: donateNameTxtField)
        
        setBtnUI(btn: signUpBtn)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setTxtFieldUI(txtField: UITextField) {
        txtField.layer.addBorder([.bottom], color: UIColor.gray, width: 1)
    }
    
    func setBtnUI(btn: UIButton) {
        btn.layer.backgroundColor = UIColorFromRGB(rgbValue: 0xD9EBF0).cgColor
        btn.layer.cornerRadius = 10
        
        btn.layer.shadowColor = UIColor.gray.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize.init(width: 3.0, height: 3.0)
        btn.layer.shadowRadius = 3
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
