//
//  LoginViewController.swift
//  Willing
//
//  Created by Kim on 2021/03/29.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var pwdTxtField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setTxtField(txtField: emailTxtField)
        setTxtField(txtField: pwdTxtField)
        setBtnUI(btn: loginBtn)
        setBtnUI(btn: signUpBtn)
    }
    
    func setBtnUI(btn: UIButton) {
        btn.layer.backgroundColor = UIColor(named: "PRIMARY BLUE")?.cgColor
        btn.layer.cornerRadius = 10
        
        btn.layer.shadowColor = UIColor.gray.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize.init(width: 3.0, height: 3.0)
        btn.layer.shadowRadius = 3
        
    }
    
    func setTxtField(txtField: UITextField) {
        txtField.layer.addBorder([.bottom], color: UIColor.gray, width: 1)
    }
    
    @IBAction func LoginBtnClicked(_ sender: Any) {
//        let email = emailTxtField.text
//        let pwd = pwdTxtField.text
        let email: String? = "skycat0212@jejunu.ac.kr"
        let pwd: String? = "123456"
        if email == "" || pwd == "" { return }
        
        if let email = email, let pwd = pwd {
            DBNetwork.login(email: email, pwd: pwd) {
                resultCode in
                switch resultCode {
                case 1: // 사용자 정보 없음
                    let alertController = UIAlertController(title: "사용자 정보 없음", message: "가입되지 않은 계정이거나, 비밀번호가 틀렸습니다.", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alertController.addAction(okButton)
                    self.present(alertController, animated: true, completion: nil)
                    break
                case 2: // 이메일 인증 필요
                    let alertController = UIAlertController(title: "이메일 인증 필요", message: "이메일을 확인하여 메일 인증을 진행해주세요.", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alertController.addAction(okButton)
                    self.present(alertController, animated: true, completion: nil)
                    break
                case 3: // 로그인 성공
                    self.toMainView()
                    break
                default:
                    break
                }
            }
        }
    }
    
    func toMainView() {
        let tabBarController = UITabBarController()
        
        let mainVC = MainViewController()
        let mainNaviVC = UINavigationController(rootViewController: mainVC)
        
        let rankingVC = JudgeVC()
        let rankingNaviVC = UINavigationController(rootViewController: rankingVC)
        
        let feedVC = FeedViewController()
        let feedNaviVC = UINavigationController(rootViewController: feedVC)
        
        let friendsVC = FriendsViewController()
        let friendsNaviVC = UINavigationController(rootViewController: friendsVC)
        
        let myPageVC = MyPageViewContoller()
        let myPageNaviVC = UINavigationController(rootViewController: myPageVC)

        mainNaviVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "chellenges")?.resizeImage(targetSize: CGSize(width: 30, height: 25)), tag: 0)
        rankingNaviVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ranking")?.resizeImage(targetSize: CGSize(width: 30, height: 25)), tag: 0)
        feedNaviVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "feed")?.resizeImage(targetSize: CGSize(width: 25, height: 25)), tag: 0)
        friendsNaviVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "friends")?.resizeImage(targetSize: CGSize(width: 30, height: 50)), tag: 0)
        myPageNaviVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "my")?.resizeImage(targetSize: CGSize(width: 25, height: 25)), tag: 0)
        
        tabBarController.viewControllers = [mainNaviVC, rankingNaviVC, feedNaviVC, friendsNaviVC, myPageNaviVC]
        
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true, completion: nil)
        
    }
    
    @IBAction func SignUpBtnClicked(_ sender: Any) {
        let vc = SignUpViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
}

