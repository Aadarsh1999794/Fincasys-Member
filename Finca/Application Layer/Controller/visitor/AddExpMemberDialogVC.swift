//
//  AddExpMemberDialogVC.swift
//  Finca
//
//  Created by harsh panchal on 19/06/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit

class AddExpMemberDialogVC: BaseVC {
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var tfName: ACFloatingTextfield!
    @IBOutlet weak var tfMobileNo: ACFloatingTextfield!
    @IBOutlet weak var tfNoOfVisitor: ACFloatingTextfield!
    @IBOutlet weak var tfVisitingDate: ACFloatingTextfield!
    @IBOutlet weak var tfVisitingTime: ACFloatingTextfield!
    @IBOutlet weak var tfVisitingReason: ACFloatingTextfield!
    @IBOutlet weak var lblMainView: UIView!
    @IBOutlet weak var viewChooseImage: UIView!
    @IBOutlet weak var imgVisitor: UIImageView!
    let toolBar = UIToolbar()
    let datePicker = UIDatePicker()
    var dateFormatter = DateFormatter()
    var visitorData : Exp_Visitor_Model!
    var isEditVisitorCalled =  false
    override func viewDidLoad() {
        super.viewDidLoad()
        lblMainView.layer.cornerRadius = 10
        imgVisitor.layer.borderColor = #colorLiteral(red: 0.9556098902, green: 0, blue: 0, alpha: 1)
        imgVisitor.layer.cornerRadius =  imgVisitor.frame.height/2
        imgVisitor.layer.borderWidth = 2
        viewChooseImage.layer.borderWidth = 0.5
        viewChooseImage.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tfVisitingDate.inputView = datePicker
        tfVisitingTime.inputView = datePicker
        tfVisitingTime.delegate = self
        tfVisitingDate.delegate = self
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolBar.setItems([doneButton], animated: true)
        tfVisitingDate.inputAccessoryView   = toolBar
        tfVisitingTime.inputAccessoryView     = toolBar
        doneButtonOnKeyboard(textField: tfName)
        doneButtonOnKeyboard(textField: tfMobileNo)
        doneButtonOnKeyboard(textField: tfNoOfVisitor)
        doneButtonOnKeyboard(textField: tfVisitingReason)
        
        datePicker.minimumDate = Date()
        tfMobileNo.delegate = self
        tfNoOfVisitor.delegate = self
        
    if isEditVisitorCalled{
        
            if visitorData.visitorProfile != nil {
            Utils.setImageFromUrl(imageView: imgVisitor, urlString: visitorData.visitorProfile)
            }
            tfName.text = visitorData.visitorName!
            tfMobileNo.text = visitorData.visitorMobile!
            tfNoOfVisitor.text = visitorData.vistorNumber!
            tfVisitingDate.text = visitorData.visitDate!
            tfVisitingTime.text = visitorData.visitTime!
            tfVisitingReason.text = visitorData.visitingReason!
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        addInputAccessoryForTextFields(textFields: [tfName,tfMobileNo,tfNoOfVisitor,tfVisitingReason], dismissable: true, previousNextable: true)
    }
    
    @IBAction func btnCancelTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func doneButtonTapped() {
        if tfVisitingDate.isFirstResponder {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            tfVisitingDate.text = dateFormatter.string(from: datePicker.date)
        }
        
        if tfVisitingTime.isFirstResponder {
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            tfVisitingTime.text = dateFormatter.string(from: datePicker.date)
        }
        
        self.view.endEditing(true)
    }
    func dp(_ sender: UITextField) {
        switch sender {
        case tfVisitingDate:
            
            break;
            
        case tfVisitingTime:
            
            break;
            
        default:
            break;
        }
        
        
    }
    
    @objc func donePicker(sender : UIBarButtonItem) {
        switch sender.tag {
        case 1:
            print ("date")
        case 2:
            print("time")
        default:
            break;
        }
        //        toolBar.removeFromSuperview()
        //        datePickerView.removeFromSuperview()
    }
    
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        tfVisitingDate.text = dateFormatter.string(from: sender.date)
        
    }
    @objc func handleTimePicker(sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        tfVisitingTime.text = formatter.string(from: sender.date)
        
    }
    @IBAction func btnChooseImage(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func btnSubmit(_ sender: UIButton) {
        if validateData() {
             doCallExpVisitorDetailsApi()
        }
       
        
    }
    func doCallExpVisitorDetailsApi() {
        
        if isEditVisitorCalled {
            self.showProgress()
//            if imgVisitor.image  == UIImage(named:"no-image-available"){
//            }
            let params = ["key":ServiceNameConstants.API_KEY,
                          "addExVisitor":"addExVisitor",
                          "society_id":doGetLocalDataUser().society_id!,
                          "floor_id":doGetLocalDataUser().floor_id!,
                          "block_id":doGetLocalDataUser().block_id!,
                          "unit_id":doGetLocalDataUser().unit_id!,
                          "user_id":doGetLocalDataUser().user_id!,
                          "visitor_name":tfName.text!,
                          "visitor_mobile":tfMobileNo.text!,
                          "number_of_visitor":tfNoOfVisitor.text!,
                          "visiting_reason":tfVisitingReason.text!,
                          "visitor_profile_photo":convertImageTobase64(imageView: imgVisitor),
                          "visit_date":tfVisitingDate.text!,
                          "visit_time":tfVisitingTime.text!,
                          "user_name":doGetLocalDataUser().user_full_name!,
                          "update":"1",
                          "visitor_id":visitorData.visitorID!]
            
            print("param" , params)
            
            let request = AlamofireSingleTon.sharedInstance
            
            request.requestPost(serviceName: ServiceNameConstants.VISITOR_CONTROLLER, parameters: params) { (json, error) in
                self.hideProgress()
                
                if json != nil {
                    
                    do {
                        
                        let response = try JSONDecoder().decode(CommonResponse.self, from:json!)
                        if response.status == "200" {
                            
                            NotificationCenter.default.post(name: NSNotification.Name(StringConstants.KEY_NOTIFICATION_VISITOR), object: nil)
                            self.dismiss(animated: true, completion: nil)
                            
                        }else {
                            
                        }
                        print(json as Any)
                    } catch {
                        print("parse error")
                    }
                }
            }
      
        }else{
            self.showProgress()
            if imgVisitor.image  == UIImage(named:"no-image-available"){
            }
            let params = ["key":ServiceNameConstants.API_KEY,
                          "addExVisitor":"addExVisitor",
                          "society_id":doGetLocalDataUser().society_id!,
                          "floor_id":doGetLocalDataUser().floor_id!,
                          "block_id":doGetLocalDataUser().block_id!,
                          "unit_id":doGetLocalDataUser().unit_id!,
                          "user_id":doGetLocalDataUser().user_id!,
                          "visitor_name":tfName.text!,
                          "visitor_mobile":tfMobileNo.text!,
                          "number_of_visitor":tfNoOfVisitor.text!,
                          "visiting_reason":tfVisitingReason.text!,
                          "visitor_profile_photo":convertImageTobase64(imageView: imgVisitor),
                          "visit_date":tfVisitingDate.text!,
                          "visit_time":tfVisitingTime.text!,
                          "user_name":doGetLocalDataUser().user_full_name!,
                          "update":"0",
                          "visitor_id":"0"]
            
            print("param" , params)
            
            let request = AlamofireSingleTon.sharedInstance
            
            request.requestPost(serviceName: ServiceNameConstants.VISITOR_CONTROLLER, parameters: params) { (json, error) in
                self.hideProgress()
                
                if json != nil {
                    
                    do {
                        
                        let response = try JSONDecoder().decode(CommonResponse.self, from:json!)
                        if response.status == "200" {
                            
                            NotificationCenter.default.post(name: NSNotification.Name(StringConstants.KEY_NOTIFICATION_VISITOR), object: nil)
                            self.dismiss(animated: true, completion: nil)
                            
                        }else {
                            
                        }
                        print(json as Any)
                    } catch {
                        print("parse error")
                    }
                }
            }
            
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch (textField) {
        case tfVisitingDate:
            datePicker.datePickerMode = .date
            break;
        case tfVisitingTime:
            datePicker.datePickerMode = .time
        default:
            break;
        }
    }
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
    
    
    @objc func keyboardWillBeHidden(aNotification: NSNotification) {
        
        
        let contentInsets: UIEdgeInsets = UIEdgeInsets.zero
        self.scrollview.contentInset = contentInsets
        self.scrollview.scrollIndicatorInsets = contentInsets
    }
    
    private func textFieldDidBeginEditing(textField: UITextField) {
        tfName = (textField as! ACFloatingTextfield)
    }
    
    private func textFieldDidEndEditing(textField: UITextField) {
        tfName = nil
    }
    @objc  func keyboardWillShow(notification: NSNotification) {
        //Need to calculate keyboard exact size due to Apple suggestions
        
        
        self.scrollview.isScrollEnabled = true
        let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        
        self.scrollview.contentInset = contentInsets
        self.scrollview.scrollIndicatorInsets = contentInsets
        //viewHieght.constant = contentInsets.bottom
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize.height
        if tfName != nil
        {
            if (!aRect.contains(tfName!.frame.origin))
            {
                self.scrollview.scrollRectToVisible(tfName!.frame, animated: true)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == tfMobileNo {
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        if textField == tfNoOfVisitor {
            let maxLength = 3
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
        
    }
    
    func validateData() -> Bool {
        var isValide = true
        
        if tfName.text == "" {
            tfName.showErrorWithText(errorText: "Enter Full Name")
            isValide = false
        }
        if tfNoOfVisitor.text == "" {
            tfNoOfVisitor.showErrorWithText(errorText: "Add Number of visitor")
            isValide = false
        }
        
        
        if tfVisitingDate.text == "" {
            tfVisitingDate.showErrorWithText(errorText: "Select visiting date")
            isValide = false
        }
        if tfVisitingTime.text == "" {
            tfVisitingTime.showErrorWithText(errorText: "Select visiting time")
            isValide = false
        }
        return isValide
    }
}
extension AddExpMemberDialogVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        imgVisitor.image = selectedImage
    }
}
