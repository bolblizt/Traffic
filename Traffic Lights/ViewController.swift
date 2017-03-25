//
//  ViewController.swift
//  Traffic Lights
//

import UIKit

class ViewController: UIViewController, SwitchingLightDelegate {

    @IBOutlet weak var northLight:UIImageView!
    @IBOutlet weak var southLight:UIImageView!
    @IBOutlet weak var eastLight:UIImageView!
    @IBOutlet weak var westLight:UIImageView!
    @IBOutlet weak var startButton:UIButton!
    var buttonState:Bool = false
    var theTimer:Timer!
    var switchTimer:Timer!
    var imageName = "green"
    var trafficSwitch:SwitchingLight!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Traffic"
        DispatchQueue.global(qos: .default).async {
            self.trafficSwitch = SwitchingLight()
            self.trafficSwitch.delegate = self
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func StartTraffic(){
        
        if !self.buttonState{
            self.buttonState = true
            
            DispatchQueue.main.async {
                self.ImageSetup()
            }
            self.trafficSwitch.StartAnimate(amberTimer:3.0, switchTimer:5.0)
        }
        else
        {
            self.buttonState = false
            self.trafficSwitch.StopAnimate()
            DispatchQueue.main.async {
                self.startButton.setImage(UIImage(named: "start"), for: UIControlState())
            }
            
        }
       
    }
    
    func ImageSetup(){
        
        var defaultImage:UIImage = UIImage(named:"green")!
        
        self.southLight.image = defaultImage
        self.northLight.image = defaultImage
        defaultImage = UIImage(named:"red")!
        
        self.eastLight.image = defaultImage
        self.westLight.image = defaultImage
        DispatchQueue.main.async {
           self.startButton.setImage(UIImage(named: "stop"), for: UIControlState())
        }
        
        
        
    }
    
    
    // MARK: SwitchingLightDelegates
    func AmberImage(marker:Bool){
        DispatchQueue.main.async {
            
            let amberImage = UIImage(named:"amber")
            if marker {
                self.southLight.image = amberImage
                self.northLight.image = amberImage
            }
            else
            {
                self.eastLight.image = amberImage
                self.westLight.image = amberImage
            }
           
        }
        
    }
    
    func UpdateImageColor(colorImage:String, marker:Bool)  {
        
        let trafficImage =  UIImage(named:colorImage)
        DispatchQueue.main.async {
            if marker {
                self.southLight.image = trafficImage
                self.northLight.image = trafficImage
            }
            else
            {
                self.eastLight.image = trafficImage
                self.westLight.image = trafficImage
            }
        }
    }
   
    
    func UpdateImageColor2(colorImage:String)  {

        DispatchQueue.main.async {
            self.eastLight.image = UIImage(named:colorImage)
           self.westLight.image = UIImage(named:colorImage)
            
        }
        
    }

 
}

