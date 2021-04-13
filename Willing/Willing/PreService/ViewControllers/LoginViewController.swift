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
        btn.layer.backgroundColor = UInt(0xD9EBF0).cgColor
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
        let email = emailTxtField.text
        let pwd = pwdTxtField.text
        if email == "" || pwd == "" {
            return
        }
        if let email = email, let pwd = pwd {
            Auth.auth().signIn(withEmail: email, password: pwd) { [weak self] authResult, error in
                print("authResult : ", authResult)
                print("error : ", error)
              guard let strongSelf = self else { return }
              // ...
                let user = Auth.auth().currentUser;
                print("user : ", user)
                if authResult == nil {
                    let alertController = UIAlertController(title: "사용자 정보 없음", message: "가입되지 않은 계정이거나, 비밀번호가 틀렸습니다.", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alertController.addAction(okButton)
                    self?.present(alertController, animated: true, completion: nil)
                } else if user?.isEmailVerified == false {
                    let alertController = UIAlertController(title: "이메일 인증 필요", message: "이메일을 확인하여 메일 인증을 진행해주세요.", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alertController.addAction(okButton)
                    self?.present(alertController, animated: true, completion: nil)
                } else {
                    self?.toMainView()

                }
            }
        }
        
    }
    
    func toMainView() {
//        let vc = MainViewController()
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
        
        let tabBarController = UITabBarController()
        
        let mainVC = MainViewController()
        let mainNaviVC = UINavigationController(rootViewController: mainVC)
        
        
        let rankingVC = RankingViewController()
        let feedVC = FeedViewController()
        let friendsVC = FriendsViewController()
        let myPageVC = MyPageViewContoller()
        
        mainNaviVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "chellenges"), tag: 0)
        rankingVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ranking"), tag: 0)
        feedVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "feed"), tag: 0)
        friendsVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "friends"), tag: 0)
        myPageVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "my"), tag: 0)
                
        tabBarController.viewControllers = [mainNaviVC, rankingVC, feedVC, friendsVC, myPageVC]
        
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true, completion: nil)
        
        
        
    }
    
    
    @IBAction func SignUpBtnClicked(_ sender: Any) {
        let vc = SignUpViewController()
//        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}





