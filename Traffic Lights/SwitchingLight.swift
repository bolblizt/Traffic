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
protocol SwitchingLightDelegate {
    
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
        
        self.theTimer.invalidate()
        self.switchTimer.invalidate()
        self.switchTimer2.invalidate()
        self.theTimer2.invalidate()
    }
    
    
    func NorthSouth(){
        
        print("Hello")
        
        self.theTimer = Timer.scheduledTimer(timeInterval: self.northSouth!.amberTimer, target: self, selector:#selector(SwitchingLight.NorthSouth2) , userInfo: nil, repeats: false)
        self.delegate.AmberImage(marker:true)
        self.imageMarker = true
       
    }

    func NorthSouth2(){
        
        print("Hello2")
    
        if self.imageMarker {
            if imageName == "green"{
                
            
                //east west
                self.perform(#selector(SwitchingLight.EastWest), with: nil, afterDelay: 2.0)
                
                imageName = "red"
                self.delegate.UpdateImageColor(colorImage: imageName, marker: self.imageMarker)
                self.switchTimer = Timer.scheduledTimer(timeInterval: switchDelay, target: self, selector:#selector(SwitchingLight.NorthSouth2) , userInfo: nil, repeats: false)
                
                
            }
            else{
                imageName = "green"
                
                self.delegate.UpdateImageColor(colorImage: imageName, marker: self.imageMarker)
                self.switchTimer = Timer.scheduledTimer(timeInterval: (self.northSouth?.switchTimer)!, target: self, selector:#selector(SwitchingLight.NorthSouth) , userInfo: nil, repeats: false)
            }

        }
            
     }

    /*
    func Sample3(){
        
        imageName = "green"
        
        self.switchTimer = Timer.scheduledTimer(timeInterval: (self.northSouth?.switchTimer)!, target: self, selector:#selector(SwitchingLight.NorthSouth) , userInfo: nil, repeats: false)
        self.delegate.UpdateImageColor(colorImage: imageName, marker: self.imageMarker)
    }*/
    
    
    //east west
    func EastWest(){
        
        self.imageName2 = "green"
        self.delegate.UpdateImageColor(colorImage: self.imageName2, marker: false)
        self.switchTimer2 = Timer.scheduledTimer(timeInterval: (self.eastWestLight?.switchTimer)!, target: self, selector:#selector(SwitchingLight.EastWestAmber) , userInfo: nil, repeats: false)
        
    }
    
    
    func EastWestAmber(){
        
        self.theTimer2 = Timer.scheduledTimer(timeInterval: self.eastWestLight!.amberTimer, target: self, selector:#selector(SwitchingLight.EastWestGreenRed) , userInfo: nil, repeats: false)
        self.delegate.AmberImage(marker:false)

    }
    
    func EastWestGreenRed(){
        
        if imageName2 == "green"{
            
            self.imageName2 = "red"
            self.delegate.UpdateImageColor(colorImage: self.imageName2, marker: false)
        
        }
    }
    
}
