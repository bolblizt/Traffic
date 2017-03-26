//
//  Traffic_LightsTests.swift
//  Traffic LightsTests
//

import XCTest
@testable import Traffic_Lights

class Traffic_LightsTests: XCTestCase {
    
    var vc:ViewController! = nil
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = storyboard.instantiateViewController(withIdentifier: "MainView")  as! ViewController
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testTrafficLight(){
        
        
        //vc.viewDidLoad()
        vc.setupTraffic()
        vc.trafficSwitch.StartAnimate(amberTimer: 5, switchTimer: 10)
        XCTAssert(vc.trafficSwitch.switchDelay == 19, "Delay")
       
        
        
    }
    
 
    
    func testTrafficTimer(){
        
        let traffic = SwitchingLight()
          traffic.StartAnimate(amberTimer: 5.0, switchTimer: 30.0)
        XCTAssertNotNil(traffic.StartAnimate(amberTimer: 2.0, switchTimer: 1.0))
      //  //XCTAssertNil(traffic.StartAnimate(amberTimer: 2.0, switchTimer: 1.0))

        
    }
    
}
