//
//  ViewController.swift
//  FirebaseSimpleApp
//
//  Created by admin on 9/26/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var imgUserPic: UIImageView!
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var tfChangeName: UITextField!
    @IBOutlet weak var tfChangePhotoURL: UITextField!
    @IBAction func btnSignUpTouch(sender: AnyObject) {
        
        
        FIRAuth.auth()?.createUserWithEmail(self.tfUsername.text!, password: self.tfPassword.text!, completion: { (user, error) in
            if user != nil {
                
                AlertDialog.showAlert("Success", message: "You have created your account", viewController: self)
            }else{
                AlertDialog.showAlert("Fail", message: "\(error!.userInfo["NSLocalizedDescription"] as! String)", viewController: self)
                
            }
        })
    }
    @IBAction func btnLogInTouch(sender: AnyObject) {
        FIRAuth.auth()?.signInWithEmail(self.tfUsername.text!, password: self.tfPassword.text!, completion: { (user, error) in
            if let user = user {
                
                self.lblID.text = user.uid
                self.lblEmail.text = user.email
                
                
                if let name = user.displayName {
                    self.lblName.text = name
                }else{
                    self.lblName.text = "..."
                }
                
                
                if let imgURL = user.photoURL{
                    if String(imgURL) != "" {
                        self.imgUserPic.image = UIImage(data: NSData(contentsOfURL: imgURL)!)
                    }else
                    {
                        
                    }
                }
                
                // lam mo button log In
                self.btnLogIn.userInteractionEnabled = false
                self.btnLogIn.alpha = 0.5
                // lam ro button log Out
                self.btnLogOut.userInteractionEnabled = true
                self.btnLogOut.alpha = 1
                AlertDialog.showAlert("Success", message: "Login Successfully", viewController: self)
            }else
            {
                AlertDialog.showAlert("Fail", message: "\(error!.userInfo["NSLocalizedDescription"] as! String)", viewController: self)
            }
        })
        
    }
    @IBAction func btnLogOutTouch(sender: AnyObject) {
        try! FIRAuth.auth()?.signOut()
        self.btnLogIn.userInteractionEnabled = true
        self.btnLogIn.alpha     = 1
        self.btnLogOut.userInteractionEnabled = false
        self.btnLogOut.alpha    = 0.5
        self.lblName.text       = nil
        self.lblEmail.text      = nil
        self.lblID.text         = nil
        self.imgUserPic.image   = nil
        self.tfUsername.text    = nil
        self.tfPassword.text    = nil
        
    }
    @IBAction func btnChange(sender: AnyObject) {
        let user = FIRAuth.auth()?.currentUser
        if let user = user {
            let changeRequest = user.profileChangeRequest()
            changeRequest.displayName   = self.tfChangeName.text
            changeRequest.photoURL      = NSURL(string: self.tfChangePhotoURL.text!)
            changeRequest.commitChangesWithCompletion({ (error) in
                if let error = error {
                    AlertDialog.showAlert("Error", message: "\(error.userInfo["NSLocalizedDescription"] as! String)", viewController: self)
                }else
                {
                    AlertDialog.showAlert("Success", message: "Your profile have been updated", viewController: self)
                    
                    self.lblID.text = user.uid
                    self.lblEmail.text = user.email
                    
                    
                    if let name = user.displayName {
                        self.lblName.text = name
                    }else{
                        self.lblName.text = "..."
                    }
                    
                    
                    if let imgURL = user.photoURL{
                        if String(imgURL) != "" {
                            self.imgUserPic.image = UIImage(data: NSData(contentsOfURL: imgURL)!)
                        }else
                        {
                            
                        }
                    }
                    
                }
            })
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.btnLogOut.userInteractionEnabled = false
        self.btnLogOut.alpha = 0.5
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

