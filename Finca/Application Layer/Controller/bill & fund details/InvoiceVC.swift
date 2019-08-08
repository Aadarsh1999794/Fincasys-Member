//
//  InvoiceVC.swift
//  Finca
//
//  Created by anjali on 31/07/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit
import WebKit
class InvoiceVC: BaseVC , WKNavigationDelegate{
    
    @IBOutlet weak var viewWebview: UIView!
    var webView : WKWebView!
    var strUrl:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let url = URL(string: strUrl)
        let myRequest = URLRequest(url: url!)
        print("url" , url)
        webView = WKWebView(frame: self.view.frame)
        webView.navigationDelegate = self
        //self.webView.scrollView.delegate = self
        webView.load(myRequest)
        self.viewWebview.addSubview(webView)
        self.viewWebview.sendSubviewToBack(webView)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideProgress()
        print(error)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showProgress()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideProgress()
        
    }
  
    
    @IBAction func onClickPrint(_ sender: Any) {
        Priner()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        doPopBAck()
    }
    
    func Priner() {
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = UIPrintInfo.OutputType.general
        printInfo.jobName = "Invoice Print"
        
        // Set up print controller
        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo
        printController.showsNumberOfCopies = false
        
        // Assign a UIImage version of my UIView as a printing iten
        printController.printingItem = self.viewWebview.toImage()
        
        // Do it
        printController.present(from: self.view.frame, in: self.view, animated: true, completionHandler: nil)
    }

}
extension UIView {
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
