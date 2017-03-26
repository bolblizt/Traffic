//
//  SwitchingLight.swift
//  Traffic Lights
//
//  Created by user on 24/3/17.
//
//

import UIKit


enum SwitchingMode{
    
    case normal
    case notNormal
    
}
protocol SwitchingLightDelegate: class {
    
    func AmberImage(marker:Bool)
    func UpdateImageColor(colorImage:String, marker:Bool)
    func UpdateImageColor2(colorImage:String)
}



class SwitchingLight: NSObject {

    var northSouth:TrafficLight?
    var eastWestLight:TrafficLight?
    var delegate:SwitchingLightDelegate!
    var theTimer:Timer!
     var theTimer2:Timer!
    var switchTimer:Timer!
    var switchTimer2:Timer!
    var imageName = "green"
    var imageName2 = "green"
    var imageMarker:Bool = true
    var switchDelay:Double = 0.0
    
    
   override init() {

        northSouth = TrafficLight()
        eastWestLight = TrafficLight()
       
    }
    

    
    func StartAnimate(amberTimer:Double, switchTimer:Double ){

        switchDelay = amberTimer + switchTimer + 2 + 2
        self.northSouth?.amberTimer = amberTimer
        self.northSouth?.switchTimer = switchTimer
        self.eastWestLight?.amberTimer = amberTimer
        self.eastWestLight?.switchTimer = switchTimer
        

              self.NorthSouth()
    }
    
    
    func StopAnimate(){
        
        if self.theTimer != nil{
            self.theTimer.invalidate()
        }
        
        if self.switchTimer != nil{
            self.switchTimer.invalidate()
        }
        
        if self.theTimer2 != nil {
            self.theTimer2.invalidate()
        }
        
        if self.switchTimer2 != nil{
            self.switchTimer2.invalidate()
        }
        
        
    }
    
    //North South Traffic
    func NorthSouth(){
        
        print("Hello")
        
        self.theTimer = Timer.scheduledTimer(timeInterval: self.northSouth!.amberTimer, target: self, selector:#selector(SwitchingLight.NorthSouth2) , userInfo: nil, repeats: false)
        self.imageMarker = true
        guard (self.delegate != nil) else {
            print("delegate is nil")
            
            return
        }
        self.delegate.AmberImage(marker:true)
        
        
    }

    func NorthSouth2(){
        
       
    
        self.UpdateImageNorthSouth(imageStr: self.imageName, isTrueMarker: self.imageMarker)
            
     }

    
    func UpdateImageNorthSouth(imageStr:String, isTrueMarker:Bool){
        
       if isTrueMarker {
            if imageStr == "green"{
                
                
                //east west
                self.perform(#selector(SwitchingLight.EastWest), with: nil, afterDelay: 2.0)
                
                self.imageName = "red"
                self.delegate.UpdateImageColor(colorImage: imageName, marker: self.imageMarker)
                self.switchTimer = Timer.scheduledTimer(timeInterval: switchDelay, target: self, selector:#selector(SwitchingLight.NorthSouth2) , userInfo: nil, repeats: false)
                
                
            }
            else{
                self.imageName = "green"
                
                self.delegate.UpdateImageColor(colorImage: imageName, marker: self.imageMarker)
                self.switchTimer = Timer.scheduledTimer(timeInterval: (self.northSouth?.switchTimer)!, target: self, selector:#selector(SwitchingLight.NorthSouth) , userInfo: nil, repeats: false)
            }
            
        }

        
    }
    

    
    
    
    //East West Traffic 
    func EastWest(){
    
            self.UpdateEastWest(imageStr:"green")

    }
    
    
    func UpdateEastWest(imageStr:String){
        self.imageName2 = imageStr
        self.delegate.UpdateImageColor(colorImage: self.imageName2, marker: false)
        self.switchTimer2 = Timer.scheduledTimer(timeInterval: (self.eastWestLight?.switchTimer)!, target: self, selector:#selector(SwitchingLight.EastWestAmber) , userInfo: nil, repeats: false)
        

    }
    
    func EastWestAmber(){
        
        self.theTimer2 = Timer.scheduledTimer(timeInterval: self.eastWestLight!.amberTimer, target: self, selector:#selector(SwitchingLight.EastWestGreenRed) , userInfo: nil, repeats: false)
        self.delegate.AmberImage(marker:false)

    }
    
    func EastWestGreenRed(){
        
        self.UpdateImageGreen(imageStr: self.imageName2, imageMarker:false)

    }
    
    func UpdateImageGreen(imageStr:String, imageMarker:Bool){
        
        if imageStr == "green"{
            
            self.imageName2 = "red"
            self.delegate.UpdateImageColor(colorImage: self.imageName2, marker: imageMarker)
            
        }
        
    }
    
}
