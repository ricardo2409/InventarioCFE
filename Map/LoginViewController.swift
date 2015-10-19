//
//  LoginViewController.swift
//  Map
//
//  Created by Ricardo Trevino on 4/5/15.
//  Copyright (c) 2015 Ricardo Trevino. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameLogin: UITextField! = nil
    @IBOutlet weak var passwordLogin: UITextField! = nil
    
    var actIndicador:UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actIndicador.center = self.view.center
        self.actIndicador.hidesWhenStopped = true
        self.actIndicador.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.actIndicador)
        self.usernameLogin.resignFirstResponder()
        // Do any additional setup after loading the view.
    }

    @IBAction func Login(sender: UIButton) {
        let username = self.usernameLogin.text!
        let password = self.passwordLogin.text!
        
        if(username.utf16.count < 4 || password.utf16.count < 5)
        {
            let alert = UIAlertView(title: "Inválido", message: "Username debe ser mayor de 4 caracteres y password mayor de 5 caracteres", delegate: self, cancelButtonTitle: "ok")
            alert.show()
            
            
        } else {
            
            self.actIndicador.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username, password: password, block: { (user, error) -> Void in
                self.actIndicador.stopAnimating()
                
                if(user != nil){
                    print("Logged in")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let menuViewController = storyboard.instantiateViewControllerWithIdentifier("navigation") as! Navigation
                    self.presentViewController(menuViewController, animated: true, completion: nil)
                    
                }else{
                    print("error en login")
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
    
    @IBAction func signupAction(sender: UIButton!) {
        performSegueWithIdentifier("SignUp", sender: self)
        
    }
    @IBAction func unwindToList(segue: UIStoryboardSegue){
        
    }

    //poner unwind cuando logout
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
