//
//  TimerViewController.swift
//  Willing
//
//  Created by Kim on 2021/06/14.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    var challenge: Challenge? = nil

    var didStart: Bool = false
    var didFinish: Bool = false
    
    @IBOutlet weak var hourTxtField: UITextField!
    @IBOutlet weak var minTxtField: UITextField!
    @IBOutlet weak var secTxtField: UITextField!
    
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    
    @IBOutlet weak var endMessage: UILabel!
    @IBOutlet weak var challengeTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        challengeTitleLabel.text = challenge?.title
        
        let now=NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.locale = NSLocale(localeIdentifier: "ko_KR") as Locale
        let time = dateFormatter.string(from: now as Date)
        dateLabel.text = time
    }

    let timeSelector: Selector = #selector(TimerViewController.updateTime)
    let interval = 1.0
    var count = 0
    
    @IBAction func startBtnClicked(_ sender: Any) {
        if didStart == true { return }
        else { didStart = true }
        
        hourTxtField.isUserInteractionEnabled = false
        minTxtField.isUserInteractionEnabled = false
        secTxtField.isUserInteractionEnabled = false
        
        let hour = (hourTxtField.text! as NSString).integerValue
        let min = (minTxtField.text! as NSString).integerValue
        let sec = (secTxtField.text! as NSString).integerValue

        count = hour*3600 + min*60 + sec
        runTimer()
    }
    
    func runTimer (){
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @objc
    func updateTime() {
        if count > 0 {
            count = count - 1
            var hour = String(count/3600)
            var min = String((count - (count/3600)*3600)/60)
            var sec = String(count%60)

            if sec.count < 2 { sec = "0" + sec }
            if min.count < 2 { min = "0" + min }
            if hour.count < 2 { hour = "0" + hour }
            
            hourLabel.text = hour
            minLabel.text = min
            secLabel.text = sec
            
//            timerLabel.text = String("\(min):\(sec)")
        } else {
//            timerLabel.text = String("0:00")
            secLabel.text = "00"
            endMessage.isHidden = false
        }

    }
    


}
