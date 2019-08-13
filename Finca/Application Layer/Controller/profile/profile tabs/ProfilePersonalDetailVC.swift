//
//  ProfilePersonalDetailVC.swift
//  Finca
//
//  Created by harsh panchal on 09/08/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class ProfilePersonalDetailVC: BaseVC {
      @IBOutlet weak var switchProfile: UISwitch!
    @IBOutlet weak var tfName: ACFloatingTextfield!
    @IBOutlet weak var tfLastName: ACFloatingTextfield!
    @IBOutlet weak var tfEmail: ACFloatingTextfield!
    @IBOutlet weak var tfMobile: ACFloatingTextfield!
    @IBOutlet weak var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfName.text = doGetLocalDataUser().user_first_name
        tfLastName.text = doGetLocalDataUser().user_last_name
        tfMobile.text = doGetLocalDataUser().user_mobile
        tfEmail.text = doGetLocalDataUser().user_email
        tfName.delegate = self
        tfLastName.delegate = self
        tfEmail.delegate = self
        tfMobile.delegate = self
        switchProfile.addTarget(self, action: #selector(switchChangedProfile), for: UIControl.Event.valueChanged)
        doDisbleUI()
    }
    
    @IBAction func onEditProfile(_ sender: Any) {
        doEnsbleUI()
    }
    
    @objc func switchChangedProfile(mySwitch: UISwitch) {
        let value = mySwitch.isOn
        // Do something
        print(value)
        
        if value {
            switchProfile.thumbTintColor  = ColorConstant.green400
            switchProfile.tintColor = ColorConstant.green400
            doSwitchToProfile(public_mobile: "0")
        } else {
            switchProfile.thumbTintColor  = ColorConstant.red500
            switchProfile.tintColor = ColorConstant.red500
            doSwitchToProfile(public_mobile: "1")
        }
        doDisbleUI()
        // switchProfile.thumbTintColor
        addInputAccessoryForTextFields(textFields: [tfName,tfLastName,tfEmail,tfMobile], dismissable: true, previousNextable: true)
        tfMobile.isEnabled = false
        
    }
    
    func addInputAccessoryForTextFields(textFields: [UITextField], dismissable: Bool = true, previousNextable: Bool = false) {
        for (index, textField) in textFields.enumerated() {
            let toolbar: UIToolbar = UIToolbar()
            toolbar.sizeToFit()
            
            var items = [UIBarButtonItem]()
            if previousNextable {
                let previousButton = UIBarButtonItem(image: UIImage(named: "up-arrow"), style: .plain, target: nil, action: nil)
                previousButton.width = 30
                if textField == textFields.first {
                    previousButton.isEnabled = false
                } else {
                    previousButton.target = textFields[index - 1]
                    previousButton.action = #selector(UITextField.becomeFirstResponder)
                }
                
                let nextButton = UIBarButtonItem(image: UIImage(named: "down-arrow"), style: .plain, target: nil, action: nil)
                nextButton.width = 30
                if textField == textFields.last {
                    nextButton.isEnabled = false
                } else {
                    nextButton.target = textFields[index + 1]
                    nextButton.action = #selector(UITextField.becomeFirstResponder)
                }
                items.append(contentsOf: [previousButton, nextButton])
            }
            
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(UIView.endEditing))
            items.append(contentsOf: [spacer, doneButton])
            
            
            toolbar.setItems(items, animated: false)
            textField.inputAccessoryView = toolbar
        }
    }
    
    private func textFieldDidBeginEditing(textField: UITextField) {
        tfName = (textField as! ACFloatingTextfield)
    }
    
    private func textFieldDidEndEditing(textField: UITextField) {
        tfName = nil
    }
    
    func doSwitchToProfile(public_mobile:String) {
        self.showProgress()
        
        //let device_token = UserDefaults.standard.string(forKey: ConstantString.KEY_DEVICE_TOKEN)
        
        let  params = ["key":apiKey(),
                       "changePrivacy":"changePrivacy",
                       "society_id":doGetLocalDataUser().society_id!,
                       "public_mobile":public_mobile,
                       "user_id":doGetLocalDataUser().user_id!,
                       "unit_id":doGetLocalDataUser().unit_id!]
        print("param" , params)
        
        let requrest = AlamofireSingleTon.sharedInstance
        
        requrest.requestPost(serviceName: ServiceNameConstants.aboutController, parameters: params) { (json, error) in
            
            if json != nil {
                self.hideProgress()
                do {
                    let response = try JSONDecoder().decode(ResponseCommonMessage.self, from:json!)
                    
                    
                    if response.status == "200" {
                        
                        
                    }else {
                        //                        UserDefaults.standard.set("0", forKey: StringConstants.KEY_LOGIN)
                        self.showAlertMessage(title: "Alert", msg: response.message)
                    }
                } catch {
                    print("parse error")
                }
            }
        }
    }
    
    
    func hideProfileView() {
        
//        conHeightForProfile.constant = 60.0
        tfName.isHidden = true
        tfEmail.isHidden = true
        tfMobile.isHidden = true
        tfLastName.isHidden = true
//        viewEditProfile.isHidden = true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func showProfileView() {
        
//        conHeightForProfile.constant = 240.0
        tfName.isHidden = false
        tfEmail.isHidden = false
        tfMobile.isHidden = false
        tfLastName.isHidden = false
//        viewEditProfile.isHidden = false
        
    }
    @IBAction func btnFamilyMembersTapped(_ sender: UIButton) {
         let storyboard = UIStoryboard(name: "sub", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "idFamilyMembersVC")as! FamilyMembersVC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func btnSaveClicked(_ sender: UIButton)
    {
        
    }
    func doDisbleUI() {
        tfName.textColor = UIColor(named: "grey_60")
        tfLastName.textColor = UIColor(named: "grey_60")
        tfMobile.textColor = UIColor(named: "grey_60")
        tfEmail.textColor = UIColor(named: "grey_60")
        btnSave.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        btnSave.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        btnSave.isEnabled = false
//        bMember.isHidden = true
//        bNumber.isHidden = true
        tfName.isEnabled = false
        tfLastName.isEnabled = false
        tfEmail.isEnabled = false
        //   tfMobile.isEnabled = false
//        bSave.isHidden = true
    }
    
    func doEnsbleUI() {
        btnSave.isEnabled = true
        tfName.textColor = UIColor.black
        tfLastName.textColor = UIColor.black
        tfMobile.textColor = UIColor.black
        tfEmail.textColor = UIColor.black
        btnSave.backgroundColor = #colorLiteral(red: 0.3960784314, green: 0.2235294118, blue: 0.4549019608, alpha: 1)
        btnSave.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
//        bMember.isHidden = false
//        bNumber.isHidden = false
        
        tfName.isEnabled = true
        tfLastName.isEnabled = true
        tfEmail.isEnabled = true
        
//        bSave.isHidden = false
        
        // tfMobile.isEnabled = true
    }
}

extension ProfilePersonalDetailVC : IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return "Personal Details"
    }
}
