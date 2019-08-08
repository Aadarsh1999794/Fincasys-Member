//


import UIKit

class DailogFacilityBookVC: BaseVC {

    @IBOutlet weak var tfMonth: ACFloatingTextfield!
    @IBOutlet weak var tfPerson: ACFloatingTextfield!
    
    var responseFacilityDetails:ResponseFacilityDetails!
   // let paymentParams = PUMPaymentParam()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doneButtonOnKeyboard(textField: tfMonth)
        doneButtonOnKeyboard(textField: tfPerson)
        tfMonth.delegate = self
           tfPerson.delegate = self
        
    }
    @IBAction func onClickBook(_ sender: Any) {
        if validateData() {
            
         //   prese
            
          // present
        }
        
       
        
      /*  let paymentParams = PUMTxnParam()
        paymentParams.key = "nmCrcwHb"
        paymentParams.txnID = "xzxzx"
        paymentParams.phone = "123456789"
        paymentParams.email = "d@g.in"
        paymentParams.amount = "123"
        paymentParams.environment = .test
        paymentParams.merchantid = "5376121"
        paymentParams.surl = "https://www.payumoney.com/mobileapp/payumoney/success.php"
        paymentParams.furl = "https://www.payumoney.com/mobileapp/payumoney/failure.php"
        paymentParams.firstname = "deepak"
        paymentParams.udf1 = ""
        paymentParams.udf2 = ""
        paymentParams.udf3 = ""
        paymentParams.udf4 = ""
        paymentParams.udf5 = ""*/
      
 
        
      //  shiw
        
        
        
    }
    
    
    func validateData() -> Bool {
        var isValid = true
       
        
        
        if tfPerson.text == "" {
            tfPerson.showErrorWithText(errorText: "Enter Number of person")
        } else {
             let count = Int(tfPerson.text!)!
            if count <= 0 {
                showAlertMessage(title: "", msg: "Person should be grater than zero")
                isValid = false
                
            } else   if count > Int(responseFacilityDetails.person_limit!)! {
                showAlertMessage(title: "", msg: "Please Check Person Limit")
                isValid = false
            }
        }
       
        
        if tfMonth.text == "" {
            tfMonth.showErrorWithText(errorText: "Enter Number of month")
        } else {
            let count = Int(tfMonth.text!)!
            if count <= 0 {
                showAlertMessage(title: "", msg: "Month should be grater than zero")
                isValid = false
                
            }
            
        }
        
        
        return isValid
    }
    func doBookNow() {
        
        
        showProgress()
        //let device_token = UserDefaults.standard.string(forKey: ConstantString.KEY_DEVICE_TOKEN)
        let params = ["key":apiKey(),
                      "getFullFacilityDetails":"getFullFacilityDetails",
                      "facility_id":"",
                      "unit_name":doGetLocalDataUser().unit_name!]
        
        
        print("param" , params)
        
        let requrest = AlamofireSingleTon.sharedInstance
        
        
        requrest.requestPost(serviceName: ServiceNameConstants.getFacilityController, parameters: params) { (json, error) in
            
            if json != nil {
                self.hideProgress()
                do {
                    let response = try JSONDecoder().decode(ResponseFacilityDetails.self, from:json!)
                    
                    
                    if response.status == "200" {
                        
                        
                        
                        
                    }else {
                        self.showAlertMessage(title: "Alert", msg: response.message)
                    }
                } catch {
                    print("parse error")
                }
            }
        }
        
    }
    
    
    @IBAction func onClickCancel(_ sender: Any) {
        removeFromParent()
        view.removeFromSuperview()
    }
    override func doneClickKeyboard() {
        view.endEditing(true)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == tfMonth {
            let maxLength = 2
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        if textField == tfPerson {
            let maxLength = 2
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
        
    }
    
    
}
