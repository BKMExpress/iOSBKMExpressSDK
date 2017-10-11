//
//  ViewController.swift
//  SDK_SWIFT_SAMPLE
//
//  Created by Kadir Guzel on 12/12/16.
//  Copyright © 2016 Kadir Guzel. All rights reserved.
//

import UIKit

let kBKM_EXPRESS_SDK_API_KEY:String = "given by BKM"
let kQUICK_PAY_TOKEN:String = "Quick pay token will be given by BKM after the merchant integration"
let kPAYMENT_TOKEN:String = "Payment token will be given by BKM after the merchant integration"

class ViewController: UIViewController , BKMExpressPaymentDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        let instanceOfCustomObject: BKMExpressPaymentViewController = BKMExpressPaymentViewController(paymentToken: kPAYMENT_TOKEN, withApiKey: kBKM_EXPRESS_SDK_API_KEY, delegate: self)

        instanceOfCustomObject.setEnableDebugMode(true)
        
        self.present(instanceOfCustomObject , animated:true,completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bkmExpressPaymentDidComplete(with posResult: BKMPOSResult!) {
        NSLog("Successful payment with POS message")
    }
    
    func bkmExpressPaymentDidFail(_ error: Error!) {
        NSLog("An error has occurred on payment %@", error.localizedDescription)
    }
    
    func bkmExpressPaymentDidCancel() {
        NSLog("Payment is cancelled by user")
    }
}
