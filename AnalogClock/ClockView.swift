//
//  ClockView.swift
//  AnalogClock
//
//  Created by Juber Moulvi Abdul on 02/04/18.
//  Copyright © 2018 Juber Moulvi Abdul. All rights reserved.
//


import Foundation
import UIKit

let Pi:CGFloat = CGFloat(Double.pi)
class ClockView : UIView {
    
    func drawClockFrame() {
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = (max(bounds.width, bounds.height) / 2)
        let arcWidth: CGFloat = 0
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2*Pi
        
        let path = UIBezierPath(arcCenter: center, radius: radius-(bounds.height * 0.083),startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let strokeColor: UIColor = UIColor.brown
        path.lineWidth = arcWidth
        strokeColor.setStroke()
        path.lineWidth = (bounds.height * 0.083)
        path.stroke()
        
        let fillColor: UIColor = UIColor.white
        fillColor.setFill()
        path.fill()
    }
    
    func drawMinuteTicks() {
        let context = UIGraphicsGetCurrentContext()
        
        // save original state
        context?.saveGState()
        let strokeColor1: UIColor = UIColor.black
        strokeColor1.setFill()
        
        // minute ticks
        let minuteWidth:CGFloat = (bounds.height * 0.0125)
        let minuteSize:CGFloat = (bounds.height * 0.025)
        
        let minutePath = UIBezierPath(rect: CGRect(x: -minuteWidth/2, y: 0,
                                                   width: minuteWidth, height: minuteSize))
        
        // hour ticks
        let hourWidth:CGFloat = (bounds.height * 0.020)
        let hourSize:CGFloat = (bounds.height * 0.0333)
        
        let hourPath = UIBezierPath(rect: CGRect(x: -hourWidth/2, y: 0, width: hourWidth,height: hourSize))
        
        // move context to the center position
        context?.translateBy(x: bounds.width/2, y: bounds.height/2)
        
        let arcLengthPerGlass = Pi/30
        
        // ticks
        for i in 1...60 {
            // save the centred context
            context?.saveGState()
            
            // calculate the rotation angle
            let angle = arcLengthPerGlass * CGFloat(i) - Pi/2
            
            //rotate and translate
            context?.rotate(by: angle)
            
            // translate and fill with minute tick
            if !(i%5 == 0) {
                context?.translateBy(x: 0, y: ((bounds.height/2) - (bounds.height * 0.116)) - hourSize)
                minutePath.fill()

            } // translate and fill with hour tick
            else {
                context?.translateBy(x: 0, y: ((bounds.height/2) - (bounds.height * 0.1235)) - hourSize)
                hourPath.fill()
               
            }
            // restore the centred context for the next rotate
            context?.restoreGState()
        }
    }
    
    func drawHourNumbers() {
        let radius:CGFloat = (bounds.width/2 * 0.6 )
        var numLabel = [UILabel]()
        
        for i in 0...11 {
            numLabel.append(UILabel(frame: CGRect(x: bounds.width/2, y: bounds.height/2, width: 75, height: 75)))
            numLabel[i].textAlignment = NSTextAlignment.center
            numLabel[i].font = UIFont(name: numLabel[i].font.fontName, size: bounds.width/2 * 0.13)
            numLabel[i].text = String(i+1)
            
            let angle = CGFloat((Double(i-2) * Double.pi) / 6)
            numLabel[i].center = CGPoint(x: Double(bounds.width/2 + cos(angle) * radius), y: Double(bounds.height/2 + sin(angle) * radius))
            
            self.addSubview(numLabel[i])
        }
    }
    override func draw(_ rect: CGRect) {
        drawClockFrame()
        drawMinuteTicks()
        drawHourNumbers()
    }
}

