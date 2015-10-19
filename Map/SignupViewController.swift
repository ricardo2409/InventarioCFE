//
//  SignupViewController.swift
//  Map
//
//  Created by Ricardo Trevino on 4/5/15.
//  Copyright (c) 2015 Ricardo Trevino. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
     var actIndicador:UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actIndicador.center = self.view.center
        self.actIndicador.hidesWhenStopped = true
        self.actIndicador.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.actIndicador)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpAction(sender: UIButton) {
        let username = self.usernameField.text!
        let password = self.passwordField.text!
        let email = self.emailField.text!
        if(username.utf16.count < 4 || password.utf16.count < 5)
        {
            let alert = UIAlertView(title: "Inválido", message: "Username debe ser mayor de 4 caracteres y password mayor de 5 caracteres", delegate: self, cancelButtonTitle: "ok")
            alert.show()
            
            
        }else if(email.utf16.count < 8){
            let alert = UIAlertView(title: "Inválido", message: "Ingrese un email válido", delegate: self, cancelButtonTitle: "ok")
            alert.show()
        }else{
            self.actIndicador.startAnimating()
            let newuser = PFUser()
            newuser.username = username
            newuser.password = password
            newuser.email = email
            
            
            newuser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                self.actIndicador.stopAnimating()
                if(error == nil){
                    print("buen sign up")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let menuViewController = storyboard.instantiateViewControllerWithIdentifier("navigation") as! Navigation
                    self.presentViewController(menuViewController, animated: true, completion: nil)
                }else{
                    print(error)
                }
            })
            
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   }
