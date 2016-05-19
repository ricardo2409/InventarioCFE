//
//  ViewController.swift
//  Map
//
//  Created by Ricardo Trevino on 4/1/15.
//  Copyright (c) 2015 Ricardo Trevino. All rights reserved.
//

import UIKit
import Parse
import CoreLocation
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate, UIApplicationDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate {
    
    
    let locationManager = CLLocationManager()
    var center = CLLocationCoordinate2D(latitude: 35.0, longitude: -27.0)
    var imagen = UIImageView()
    var imagenThumbnail = UIImageView()
    var tipoAparato = 0
    var tituloAparato: String = ""
    var arregloLocations = Array<PFObject>()
    var titulo: String = ""
    var subtitulo:String = ""
    //var usuario = PFUser.currentUser()
    var imageAparato = UIImage()
    var latitude = 0
    var longitude = 0
    var type = 0
    var contadorTransformador = 0
    var contadorBancoDeCapacitores = 0
    var contadorUTR = 0
    var arregloAparatos = Array<AnnotationAparato>()
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var labelTransformadores: UILabel!
    @IBOutlet weak var labelBancoDeCapacitores: UILabel!
    @IBOutlet weak var labelUTR: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.map.delegate = self
        self.map.showsUserLocation = true
        switch1.on = true
        switch2.on = true
        switch3.on = true

        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.startUpdatingLocation()
        }
        self.pedirParse()
       
    }
    
    
   

    func pedirParse(){
        let query = PFQuery(className:"Informacion")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
//                if let objects = objects as [PFObject] {
                    for object in objects! {
                        self.arregloLocations.append(object)
                        
                        
                    }
                    //desplegar en el mapa
                    self.desplegarEnMapa()
//                }
            } else {
                // Log details of the failure
                print("Error: \(error) \(error!.userInfo)")
            }
        }

    }
    
    func desplegarEnMapa() {
        for objeto in self.arregloLocations {
            let location = objeto["Location"] as! PFGeoPoint
            let type = objeto["Type"] as! Int
//            var user = objeto["User"] as! String
            let subtitulo = objeto["Informacion"] as! String
            //var subtitulo = user.username as! String
            
            if(type == 1){
                self.titulo = "Transformador"
                self.contadorTransformador += 1
            }else if(type == 2){
                self.titulo = "Banco de Capacitores"
                self.contadorBancoDeCapacitores += 1
            } else if(type == 3){
                self.titulo = "UTR"
                self.contadorUTR += 1
            }
//            else{
//                self.titulo = "4"
//            }loca
            let imagen = objeto["Photo"] as! PFFile
            
            let latitude = location.latitude
            let longitude = location.longitude
            //Asignar el valor de los contadores a las labels
            self.labelTransformadores.text! = "\(contadorTransformador)"
            self.labelBancoDeCapacitores.text! = "\(contadorBancoDeCapacitores)"
            self.labelUTR.text! = "\(contadorUTR)"
            
            let aparato = AnnotationAparato(type: type,
                coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), title: self.titulo, url: imagen.url!, subtitle: subtitulo)
            self.arregloAparatos.append(aparato)
            self.map.addAnnotation(aparato)

            
        }
    }
    @IBAction func switch1(sender: UISwitch) {
        if(switch1.on == false) {
            for objeto in arregloAparatos{
                if(objeto.type == 1)
                {
                    self.map.removeAnnotation(objeto)
                }
                
            }
        }else{
            
            for objeto in arregloAparatos{
                if(objeto.type == 1)
                {
                    self.map.addAnnotation(objeto)
                }
                
            }
        }
    }
    @IBAction func switch2(sender: UISwitch) {
        if(switch2.on == false) {
            for objeto in arregloAparatos{
                
            
                if(objeto.type == 2)
                {
                    self.map.removeAnnotation(objeto)
                }
                
            }
        }else{
            for objeto in arregloAparatos{
                if(objeto.type == 2)
                {
                    self.map.addAnnotation(objeto)
                }
                
            }
        }
    }
    @IBAction func switch3(sender: UISwitch) {
        if(switch3.on == false) {
            for objeto in arregloAparatos{
                
                
                if(objeto.type == 3)
                {
                    self.map.removeAnnotation(objeto)
                }
                
            }

        }else{
            for objeto in arregloAparatos{
                if(objeto.type == 3)
                {
                    self.map.addAnnotation(objeto)
                }

            }
        }
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? AnnotationAparato {
            let identifier = "pin"
            let tipoAparato = annotation.type
//            let tituloAparato = annotation.title
            
            
            var view: MKPinAnnotationView
//            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
//                as? MKPinAnnotationView { // 2
//                    dequeuedView.annotation = annotation
//                    view = dequeuedView
//            } else {
            
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.animatesDrop = true
            
                
                if (tipoAparato == 1){
//                    view.pinColor = .Purple
                    if #available(iOS 9.0, *) {
                        view.pinTintColor = UIColor.purpleColor()
                    } else {
                        // Fallback on earlier versions
                    }
                }else if (tipoAparato == 2){
                    if #available(iOS 9.0, *) {
                        view.pinTintColor = UIColor.greenColor()
                    } else {
                        // Fallback on earlier versions
                    }
                    
                }else if (tipoAparato == 3){
                    if #available(iOS 9.0, *) {
                        view.pinTintColor = UIColor.redColor()
                    } else {
                        // Fallback on earlier versions
                    }
                }

                view.leftCalloutAccessoryView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                view.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
//            }
            
            return view
        }
        return nil
    }
    
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if(view.annotation!.isKindOfClass(MKUserLocation)){
            return;
        } else {
            let annotation = view.annotation as! AnnotationAparato
            let thumbnailImageView = view.leftCalloutAccessoryView as! UIImageView

            //Poner un activity monitor mientras carga la imagen
            getDataFromUrl(NSURL(string: annotation.url)!) { (data, response, error)  in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    guard let data = data where error == nil else { return }
                    thumbnailImageView.image = UIImage(data: data)
                    self.imageAparato = UIImage(data: data)!
                    
                }
            }
            //Stop animating activity monitor
        }
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            let imagen = self.imageAparato
            let annotation = view.annotation as! AnnotationAparato
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let fotoVC = sb.instantiateViewControllerWithIdentifier("ImagenVC") as! ImageController
            fotoVC.imagen = imagen
            fotoVC.title = annotation.title
            let latitude = annotation.coordinate.latitude
            let longitude = annotation.coordinate.longitude
            fotoVC.latitude = "\(latitude)"
            fotoVC.longitude = "\(longitude)"
            self.navigationController?.pushViewController(fotoVC, animated: true)

            
        }
        
    }
    
    var setRegion: Bool = true
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last as CLLocation!
        self.center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: self.center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        if (self.setRegion){
            self.map.setRegion(region, animated: false)
            self.setRegion = false
        }
        
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    
}

