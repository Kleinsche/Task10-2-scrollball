//
//  ViewController.swift
//  Task10-2
//
//  Created by 🍋 on 2016/12/8.
//  Copyright © 2016年 🍋. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController,UIAccelerometerDelegate {
    var ball:UIImageView!
    var speedX:UIAccelerationValue = 0
    var speedY:UIAccelerationValue = 0
    var cmm = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ball = UIImageView(image:UIImage(named:"圆.png"))
        ball.frame = CGRect(x:0, y:0, width:50, height:50)
        ball.center = self.view.center
        self.view.addSubview(ball)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cmm.accelerometerUpdateInterval = 0.03
        if cmm.isAccelerometerAvailable {
            cmm.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: { (data:CMAccelerometerData?, err:Error?) in
                
                self.speedX += data!.acceleration.x
                self.speedY +=  data!.acceleration.y
                var ballX=self.ball.center.x + CGFloat(self.speedX)
                var ballY=self.ball.center.y - CGFloat(self.speedY)
                
                if ballX<20 {
                    ballX=20;
                    self.speedX *= -0.3
                }else if ballX > self.view.bounds.size.width - 20 {
                    ballX=self.view.bounds.size.width - 20
                    self.speedX *= -0.3
                }
                
                if ballY<20 {
                    ballY=20
                    self.speedY *= -0.3
                } else if ballY>self.view.bounds.size.height - 20 {
                    ballY=self.view.bounds.size.height - 20
                    self.speedY *= -0.3
                }
                self.ball.center = CGPoint(x:ballX, y:ballY)
            })
        }else{
            print("加速度传感器不可用")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if cmm.isAccelerometerActive{
            cmm.stopAccelerometerUpdates()
        }
    }
    
}

