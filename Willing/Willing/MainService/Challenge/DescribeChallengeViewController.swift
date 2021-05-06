//
//  DescribeChallengeViewController.swift
//  Willing
//
//  Created by Kim on 2021/04/17.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit

class DescribeChallengeViewController: UIViewController {
    var challenge: Challenge? = nil
    
    @IBOutlet weak var detailHighlight: UIView!
    @IBOutlet weak var donateHighlight: UIView!
    @IBOutlet weak var alarmHighlight: UIView!
    @IBOutlet weak var publicHighlight: UIView!
    
    @IBOutlet weak var donatePicker: UIPickerView!
    @IBOutlet weak var setDayPicker: UIPickerView!
    @IBOutlet weak var setCntPicker: UIPickerView!
    
    @IBOutlet weak var moneyTxtfield: UITextField!
    @IBOutlet weak var setCntTxtField: UITextField!
    
    @IBOutlet weak var detailTxtView: UITextView!
    
    @IBOutlet weak var startDatePicker: UIDatePicker!

    
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var sundayBtn: UIButton!
    @IBOutlet weak var mondayBtn: UIButton!
    @IBOutlet weak var tuesdayBtn: UIButton!
    @IBOutlet weak var wednesdayBtn: UIButton!
    @IBOutlet weak var thursdayBtn: UIButton!
    @IBOutlet weak var fridayBtn: UIButton!
    @IBOutlet weak var saturdayBtn: UIButton!
    var selectedDays: Array<Int> = [0,0,0,0,0,0,0]
    @IBOutlet weak var alarmTimePicker: UIDatePicker!
    
    @IBOutlet weak var showSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        print(challenge)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setTextFieldUI(txtField: moneyTxtfield)
        setTextFieldUI(txtField: setCntTxtField)
    }
    
    
    func setUI() {
        setHightLightUI(highlightView: detailHighlight)
        setHightLightUI(highlightView: donateHighlight)
        setHightLightUI(highlightView: alarmHighlight)
        setHightLightUI(highlightView: publicHighlight)
        
        setTextView(txtView: detailTxtView)
        
        setNaviBar()
    }
    
    func setHightLightUI(highlightView: UIView) {
        highlightView.layer.cornerRadius = 10
    }
    
    func setTextFieldUI(txtField: UITextField) {
        txtField.layer.addBorder([.bottom], color: .darkGray, width: 0.8)
    }
    
    func setTextView(txtView: UITextView) {
        txtView.layer.borderWidth = 0.8
        txtView.layer.borderColor = UIColor.darkGray.cgColor
        txtView.layer.cornerRadius = 5
    }
    
    func setStartDatePicker(datePicker: UIDatePicker) {
    }
    
    func setNaviBar() {
        let nextBtn = UIBarButtonItem(title: "Start", style: .plain, target: self, action: #selector(addTapped))
        self.navigationItem.setRightBarButton(nextBtn, animated: true)
    }
    
    @objc func addTapped() {
        challenge?.money = Int(moneyTxtfield!.text!)
        
        let formatter = DateFormatter();
        formatter.dateFormat = "YYYY-MM-dd"
        let startDateStr = formatter.string(from: startDatePicker.date)
        challenge?.startdate = startDateStr
        
        challenge?.totalset = Int(setCntTxtField.text!)
        challenge?.dayperset = Int(setDayPicker.selectedRow(inComponent: 0) + 1)
        challenge?.numberperset = Int(setCntPicker.selectedRow(inComponent: 0) + 1)
        challenge?.setEndDate()
        challenge?.detail = detailTxtView.text
        
        let donationList = ["그린피스", "트리플래닛", "세이브 더 칠드런", "wwf", "한국여성재단", "굿네이버스", "유니세프", "초록우산", "월드비전"]
        challenge?.donation = donationList[donatePicker.selectedRow(inComponent: 0)]
        
        challenge?.alarm = alarmSwitch.isOn
        challenge?.alarmday = makeAlarmDays(selectedDays)
        
        formatter.dateFormat = "HH:mm aa"
        challenge?.alarmtime = formatter.string(from: alarmTimePicker.date)
        
        challenge?.show = showSwitch.isOn
        
        
        print(challenge)
  
        DBNetwork.registChallenge(challenge: challenge!, completion: { documentId in
            let vc = StartChallengeViewController()
            vc.documentId = documentId
            self.navigationController?.pushViewController(vc, animated: true)

        })

    }
    
    func makeAlarmDays(_ selectedDays: Array<Int>) -> Array<String> {
        var days: Array<String> = []
        if selectedDays[0] == 1 {days.append("sun")}
        if selectedDays[1] == 1 {days.append("mon")}
        if selectedDays[2] == 1 {days.append("tue")}
        if selectedDays[3] == 1 {days.append("wed")}
        if selectedDays[4] == 1 {days.append("thu")}
        if selectedDays[5] == 1 {days.append("fri")}
        if selectedDays[6] == 1 {days.append("sat")}

        print("days", days)
        return days
    }
    
    
    @IBAction func sunClicked(_ sender: Any) {
        if selectedDays[0] == 0 {
            selectedDays[0] = 1
            sundayBtn.setBackgroundImage(UIImage.init(systemName: "circle"), for: .normal)
        } else {
            selectedDays[0] = 0
            sundayBtn.setBackgroundImage(nil, for: .normal)
        }
    }
    
    @IBAction func monClicked(_ sender: Any) {
        if selectedDays[1] == 0 {
            selectedDays[1] = 1
            mondayBtn.setBackgroundImage(UIImage.init(systemName: "circle"), for: .normal)
        } else {
            selectedDays[1] = 0
            mondayBtn.setBackgroundImage(nil, for: .normal)
        }
    }
    
    @IBAction func tueClicked(_ sender: Any) {
        if selectedDays[2] == 0 {
            selectedDays[2] = 1
            tuesdayBtn.setBackgroundImage(UIImage.init(systemName: "circle"), for: .normal)
        } else {
            selectedDays[2] = 0
            tuesdayBtn.setBackgroundImage(nil, for: .normal)
        }
    }
    
    @IBAction func wedClicked(_ sender: Any) {
        if selectedDays[3] == 0 {
            selectedDays[3] = 1
            wednesdayBtn.setBackgroundImage(UIImage.init(systemName: "circle"), for: .normal)
        } else {
            selectedDays[3] = 0
            wednesdayBtn.setBackgroundImage(nil, for: .normal)
        }
    }
    
    @IBAction func thuClicked(_ sender: Any) {
        if selectedDays[4] == 0 {
            selectedDays[4] = 1
            thursdayBtn.setBackgroundImage(UIImage.init(systemName: "circle"), for: .normal)
        } else {
            selectedDays[4] = 0
            thursdayBtn.setBackgroundImage(nil, for: .normal)
        }
    }
    
    @IBAction func friClicked(_ sender: Any) {
        if selectedDays[5] == 0 {
            selectedDays[5] = 1
            fridayBtn.setBackgroundImage(UIImage.init(systemName: "circle"), for: .normal)
        } else {
            selectedDays[5] = 0
            fridayBtn.setBackgroundImage(nil, for: .normal)
        }
    }
    
    @IBAction func satClicked(_ sender: Any) {
        if selectedDays[6] == 0 {
            selectedDays[6] = 1
            saturdayBtn.setBackgroundImage(UIImage.init(systemName: "circle"), for: .normal)
        } else {
            selectedDays[6] = 0
            saturdayBtn.setBackgroundImage(nil, for: .normal)
        }
    }
    
    

    
}

extension DescribeChallengeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == donatePicker {
            let donationCenterNum = 9
            return donationCenterNum
        } else if pickerView == setDayPicker {
            return 14
        } else if pickerView == setCntPicker {
            return 10
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == donatePicker {
            let donationList = ["그린피스", "트리플래닛", "세이브 더 칠드런", "wwf", "한국여성재단", "굿네이버스", "유니세프", "초록우산", "월드비전"]
            return donationList[row]
        } else if pickerView == setDayPicker {
            let list = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14"]
            return list[row]
        } else if pickerView == setCntPicker {
            let list = ["1","2","3","4","5","6","7","8","9","10"]
            return list[row]
        }
        let list = ["1","2","3","4","5","6","7","8","9","10"]
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var dataArray = [""]
        
        if pickerView == donatePicker {
            let donationList = ["그린피스", "트리플래닛", "세이브 더 칠드런", "wwf", "한국여성재단", "굿네이버스", "유니세프", "초록우산", "월드비전"]
            dataArray = donationList
        } else if pickerView == setDayPicker {
            let list = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14"]
            dataArray = list
        } else if pickerView == setCntPicker {
            let list = ["1","2","3","4","5","6","7","8","9","10"]
            dataArray = list
        } else {
            let list = ["1","2","3","4","5","6","7","8","9","10"]
            dataArray = list
        }
        
        var label = UILabel()
        if let v = view {
            label = v as! UILabel
        }
        label.font = UIFont (name: "Helvetica Neue", size: 20)
        label.text =  dataArray[row]
        label.textAlignment = .center
        return label
    }
    
}


