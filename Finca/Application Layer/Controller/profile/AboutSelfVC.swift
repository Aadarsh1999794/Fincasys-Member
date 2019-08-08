//
//  AboutSelfVC.swift
//  Finca
//
//  Created by anjali on 01/08/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit

class AboutSelfVC: BaseVC {

    @IBOutlet weak var tfAbout: ACFloatingTextfield!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tfAbout.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     return   view.endEditing(true)
    }

    @IBAction func onClickBAck(_ sender: Any) {
        doPopBAck()
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        if tfAbout.text == "" {
            tfAbout.showErrorWithText(errorText: "Enter your self")
        } else {
            doSubmitData()
        }
    }
    func  doSubmitData(){
        showProgress()
        //let device_token = UserDefaults.standard.string(forKey: ConstantString.KEY_DEVICE_TOKEN)
        let params = ["key":apiKey(),
                      "addAbout":"addAbout",
                      "user_id":doGetLocalDataUser().user_id!,
                      "society_id":doGetLocalDataUser().society_id!,
                       "unit_id":doGetLocalDataUser().unit_id!,
                      "about_business":tfAbout.text!]
        
        
        print("param" , params)
        
        let requrest = AlamofireSingleTon.sharedInstance
        
        requrest.requestPost(serviceName: "aboutController.php", parameters: params) { (json, error) in
            self.hideProgress()
            if json != nil {
                // self.hideProgress()
                do {
                    let loginResponse = try JSONDecoder().decode(ResponseCommonMessage.self, from:json!)
                    
                    
                    if loginResponse.status == "200" {
                        
                        self.doGetProfileData()
                    }else {
                        //                        UserDefaults.standard.set("0", forKey: StringConstants.KEY_LOGIN)
                        self.showAlertMessage(title: "Alert", msg: loginResponse.message)
                    }
                } catch {
                    print("parse error")
                }
            }
        }
    }
    
    
    func doGetProfileData() {
        /// showProgress()
        //let device_token = UserDefaults.standard.string(forKey: ConstantString.KEY_DEVICE_TOKEN)
        let params = ["key":apiKey(),
                      "getProfileData":"getProfileData",
                      "user_id":doGetLocalDataUser().user_id!,
                      "society_id":doGetLocalDataUser().society_id!]
        
        
        print("param" , params)
        
        let requrest = AlamofireSingleTon.sharedInstance
        
        requrest.requestPost(serviceName: ServiceNameConstants.residentDataUpdateController, parameters: params) { (json, error) in
            
            if json != nil {
                // self.hideProgress()
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from:json!)
                    
                    
                    if loginResponse.status == "200" {
                        if let encoded = try? JSONEncoder().encode(loginResponse) {
                            UserDefaults.standard.set(encoded, forKey: StringConstants.KEY_LOGIN_DATA)
                        }
                        // self.initUI()
                        self.doPopBAck()
                        
                    }else {
                        //                        UserDefaults.standard.set("0", forKey: StringConstants.KEY_LOGIN)
                        self.showAlertMessage(title: "Alert", msg: loginResponse.message)
                    }
                } catch {
                    print("parse error")
                }
            }
        }
    }
}
