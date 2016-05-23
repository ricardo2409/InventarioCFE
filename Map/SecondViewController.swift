//
//  SecondViewController.swift
//  Map
//
//  Created by Ricardo Trevino on 4/2/15.
//  Copyright (c) 2015 Ricardo Trevino. All rights reserved.
//

import UIKit
import Parse
import CoreLocation
import SCLAlertView

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {

    var image: UIImage = UIImage()
    var latitude:CLLocationDegrees = 0.0
    var longitude:CLLocationDegrees = 0.0
    var presentCamera:Bool = true
    //     var imageFile: PFFile = PFFile()

    var imageFile: PFFile!
    var tipo = 0
    var material = ""
    var locationManager = CLLocationManager()
    //var usuario = PFUser.currentUser()
    
    @IBOutlet var parentVIew: UIView!
  
//    @IBOutlet weak var bienvenidaUsuario: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
//    @IBOutlet weak var switch4: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var transformadorLabel: UILabel!
    @IBOutlet weak var bancoLabel: UILabel!
    @IBOutlet weak var UTRLable: UILabel!
    @IBOutlet weak var GuardarInfoLabel: UIButton!
    @IBOutlet weak var extraInfo: UITextField!
   
    @IBOutlet weak var switchConcreto: UISwitch!
    @IBOutlet weak var switchMadera: UISwitch!
    @IBOutlet weak var switchFierro: UISwitch!
    
    
    
    
    @IBAction func switch1(sender: UISwitch) {
        if switch1.on {
            switch2.on = false
            switch3.on = false
            //switch4.on = false
        }
    }
    @IBAction func switch2(sender: UISwitch) {
        if switch2.on {
            switch1.on = false
            switch3.on = false
            //switch4.on = false
        }
    }
    @IBAction func switch3(sender: UISwitch) {
        if switch3.on {
            switch2.on = false
            switch1.on = false
            //switch4.on = false
        }
    }
//    @IBAction func switch4(sender: UISwitch) {
//        if switch4.on == true{
//            switch2.on = false
//            switch3.on = false
//            switch1.on = false
//        }
//    }
    
    @IBAction func switchConcreto(sender: UISwitch) {
        if switchConcreto.on {
            switchMadera.on = false
            switchFierro.on = false
        }
    }
    
    @IBAction func switchMadera(sender: UISwitch) {
        if switchMadera.on {
            switchConcreto.on = false
            switchFierro.on = false
        }
    }
    
    @IBAction func switchFierro(sender: UISwitch) {
        if switchFierro.on {
            switchConcreto.on = false
            switchMadera.on = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
//        checarImagen()
//        esconder()
        
        switch1.on = false
        switch2.on = false
        switch3.on = false
        //switch4.on = false
        
        switchConcreto.on = false
        switchMadera.on = false
        switchFierro.on = false
        //imageView.image = nil
        self.activityIndicator.stopAnimating()
        //self.bienvenidaUsuario.text = usuario.username

        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: #selector(SecondViewController.keyboardWillShow(_:)),
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        self.imageView.layer.borderWidth = 1
        self.imageView.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).CGColor
    }
    
    
    func esconder(){
        switch1.hidden = true
        switch2.hidden = true
        switch3.hidden = true
        extraInfo.hidden = true
        GuardarInfoLabel.hidden = true
        transformadorLabel.hidden = true
        bancoLabel.hidden = true
        UTRLable.hidden = true
    }
    
    func mostrar(){
        switch1.hidden = false
        switch2.hidden = false
        switch3.hidden = false
        extraInfo.hidden = false
        GuardarInfoLabel.hidden = false
        transformadorLabel.hidden = false
        bancoLabel.hidden = false
        UTRLable.hidden = false
    }
    
    func checarImagen(){
        if (imageView.image == nil){
            esconder()
        }else{
            mostrar()
        }
    }
    
    
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
                let resultado = 0.0 - keyboardHeight
                self.moverVistaPrincipal(resultado)
            }
        }
    }
    func moverVistaPrincipal (y:CGFloat) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.parentVIew.frame.origin.y = y
        })
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        saveImage(info[UIImagePickerControllerOriginalImage] as! UIImage)
        self.dismissViewControllerAnimated(true, completion: nil)
//        mostrar()

    }
    
   
    
    @IBAction func tomarFoto(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        self.presentViewController(picker, animated: false, completion: nil)
    }
    
    
   
    func saveImage (imageTo : UIImage) {
        //println("Estoy en save image")
        let imageData = UIImageJPEGRepresentation(imageTo, 0.5)
        self.imageFile = PFFile(name: "image.png", data: imageData!)!
        
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last as CLLocation!
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        self.latitude = center.latitude
        self.longitude = center.longitude
        
    }
    

    func resetearInformacion(){
        self.switch1.on = false
        self.switch2.on = false
        self.switch3.on = false
        //self.switch4.on = false
        self.imageView.image = nil
        self.extraInfo.text = nil
        self.switchFierro.on = false
        self.switchMadera.on = false
        self.switchConcreto.on = false


    }
    
    @IBAction func done(sender: AnyObject) {
        
        if(switch1.on){
            self.tipo = 1
        }else if(switch2.on){
            self.tipo = 2
        }else if(switch3.on){
            self.tipo = 3
        }
        
        if(switchConcreto.on){
            self.material = "Concreto"
        }else if(switchMadera.on){
            self.material = "Madera"
        }else if(switchFierro.on){
            self.material = "Fierro"
        }
        
        
        if( imageFile == nil || tipo == 0 || material == ""){
            //Falta llenar todos los campos
            SCLAlertView().showError("Error", subTitle: "Favor de llenar todos los campos") // Error

        }else{
            let prueba = PFObject(className: "Informacion")
            let point = PFGeoPoint(latitude:self.latitude, longitude:self.longitude)
            prueba["Location"] = point
            prueba["Photo"] = self.imageFile
            prueba["Type"] = self.tipo
            prueba["User"] = "admin"
            prueba["Informacion"] = self.extraInfo.text
            prueba["Material"] = self.material
            
            self.activityIndicator.startAnimating()
            
            prueba.saveInBackgroundWithBlock({ (succeed, error) -> Void in
                if(error != nil)
                {
                    //Hay un error
                    SCLAlertView().showError("Error", subTitle: "\(error)")
                }else {
                    
                    //No hay error al salvar la info
                    self.resetearInformacion()
                    

                    SCLAlertView().showSuccess("Éxito", subTitle: "¡Datos guardados exitosamente!")

                    
                }
            })
        }
        
        //esconder()
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        self.moverVistaPrincipal(0.0)

    }
    

    
    @IBAction func logout(sender: UIButton) {
        PFUser.logOut()
        if(PFUser.currentUser() == nil){
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            self.navigationController!.dismissViewControllerAnimated(true,
                completion: nil)
            appDelegate.resetApp()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
