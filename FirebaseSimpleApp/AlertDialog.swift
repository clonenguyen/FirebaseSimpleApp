//
//  AlertDialog.swift
//  FirebaseSimpleApp
//
//  Created by admin on 9/26/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import UIKit

class AlertDialog {
    class func showAlert(title: String, message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let dismissAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        
        alertController.addAction(dismissAction)
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
}