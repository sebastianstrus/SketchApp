//
//  ViewController.swift
//  SketchApp
//
//  Created by Sebastian Strus on 2018-04-17.
//  Copyright © 2018 Sebastian Strus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var drawView: DrawableView!
    @IBOutlet weak var selectedColorView: UIView!
    var selectedColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedColor = UIColor.green
        
        selectedColorView.layer.backgroundColor = UIColor.green.cgColor
        selectedColorView.layer.borderWidth = 0.5
        selectedColorView.layer.borderColor = UIColor.black.cgColor
    }
    

    @IBAction func button1Pressed(_ sender: UIButton) {
        self.selectedColorView.backgroundColor = UIColor.green
        self.drawView.color = UIColor.green }
    @IBAction func button2Pressed(_ sender: UIButton) {
        self.selectedColorView.backgroundColor = UIColor.red
        self.drawView.color = UIColor.red
    }
    @IBAction func button3Pressed(_ sender: UIButton) {
        self.selectedColorView.backgroundColor = UIColor.magenta
        self.drawView.color = UIColor.magenta
    }
    @IBAction func button4Pressed(_ sender: UIButton) {
        self.selectedColorView.backgroundColor = UIColor.yellow
        self.drawView.color = UIColor.yellow
    }
    @IBAction func button5Pressed(_ sender: UIButton) {
        self.selectedColorView.backgroundColor = UIColor.orange
        self.drawView.color = UIColor.orange
    }
}



class DrawableView: UIView {
    
    var color =  UIColor.green
    
    let path = UIBezierPath()
    var previousPoint:CGPoint
    var lineWidth:CGFloat=10.0
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override init(frame: CGRect) {
        previousPoint=CGPoint.zero
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        previousPoint = CGPoint.zero
        super.init(coder: aDecoder)
        
        let panGestureRecognizer=UIPanGestureRecognizer(target: self, action: #selector(pan))
        panGestureRecognizer.maximumNumberOfTouches = 1
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func draw(_ rect: CGRect) {
        Swift.print("draw()")
        // Drawing code
        

        color.setStroke()
        path.stroke()
        path.lineWidth = lineWidth
        
        


        
        
    }
    
    @objc func pan(panGestureRecognizer:UIPanGestureRecognizer)->Void{
        let currentPoint = panGestureRecognizer.location(in: self)
        let midPoint=self.midPoint(p0: previousPoint, p1: currentPoint)
        
        
        if panGestureRecognizer.state == .began{
            path.move(to: currentPoint)
        }
        else if panGestureRecognizer.state == .changed{
            path.addQuadCurve(to: midPoint,controlPoint: previousPoint)
        }
        
        previousPoint = currentPoint
        self.setNeedsDisplay()
        self.layoutIfNeeded()
    }
    
    func midPoint(p0:CGPoint,p1:CGPoint)->CGPoint{
        let x = (p0.x+p1.x)/2
        let y = (p0.y+p1.y)/2
        return CGPoint(x: x, y: y)
    }
}
