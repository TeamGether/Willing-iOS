//
//  LoginViewController.swift
//  Willing
//
//  Created by Kim on 2021/03/29.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var pwdTxtField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    override func viewDidAppear(_ animated: Bool) {
        setTxtField(txtField: emailTxtField)
        setTxtField(txtField: pwdTxtField)
        setBtnUI(btn: loginBtn)
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
    
    func setBtnUI(btn: UIButton) {
        btn.layer.backgroundColor = UIColorFromRGB(rgbValue: 0xD9EBF0).cgColor
        btn.layer.cornerRadius = 10
        
        btn.layer.shadowColor = UIColor.gray.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize.init(width: 3.0, height: 3.0)
        btn.layer.shadowRadius = 3
        
    }
    
    func setTxtField(txtField: UITextField) {
        txtField.layer.addBorder([.bottom], color: UIColor.gray, width: 1)
    }
    
    @IBAction func SignUpBtnClicked(_ sender: Any) {
        let vc = SignUpViewController()
//        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    // MARK: - 적합한 위치 찾기
    // 출처 : https://stackoverflow.com/questions/24074257/how-can-i-use-uicolorfromrgb-in-swift
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }


}

    // 출처 : https://devsc.tistory.com/62
extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}


