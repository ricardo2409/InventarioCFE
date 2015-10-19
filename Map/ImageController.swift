//
//  ImageController.swift
//  Map
//
//  Created by Ricardo Trevino on 4/12/15.
//  Copyright (c) 2015 Ricardo Trevino. All rights reserved.
//

import UIKit

class ImageController: UIViewController {

    @IBOutlet weak var imageFoto: UIImageView!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var long: UILabel!
    var latitude = ""
    var longitude = ""
    var imagen = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageFoto.image = self.imagen
    }
    
    override func viewWillAppear(animated: Bool) {
        self.lat.text = self.latitude
        self.long.text = self.longitude
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
