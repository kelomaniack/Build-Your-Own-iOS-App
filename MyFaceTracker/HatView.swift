//
//  HatView.swift
//  MyFaceTracker
//
//  Created by kelomaniack on 2017-09-10.
//  Copyright © 2017 Evangelos Konstantinidis. All rights reserved.
//

import UIKit

class HatView: UIView {
    var leftEye: [CGPoint]?
    var rightEye: [CGPoint]?
    let hatView = UIImageView()
    
    override init(frame: CGRect) {
        hatView.image = UIImage(named: "my_hat.png")
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        addSubview(hatView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func draw(_ rect: CGRect) {
        guard let leftEye = leftEye else { return }
        guard let rightEye = rightEye else { return }
        
        
        let eyeCornerDist = distanceFrom(leftEye[0], to: rightEye[5])
        let eyeToEyeCenter = CGPoint(x: (leftEye[0].x + rightEye[5].x) / 2, y: (leftEye[0].y + rightEye[5].y) / 2)
        
        let hairWidth = 2.85 * eyeCornerDist
        let hairHeight = (hatView.image!.size.height / hatView.image!.size.width) * hairWidth
        
        hatView.transform = CGAffineTransform.identity
        hatView.frame = CGRect(x: eyeToEyeCenter.x - hairWidth / 2, y: eyeToEyeCenter.y - 0.8 * hairHeight, width: hairWidth, height: hairHeight)
        hatView.isHidden = false
        
        hatView.setAnchorPoint(CGPoint(x: 0.5, y: 0.9))
        
        let angle = calcAngleFrom(leftEye[0], to: rightEye[5])
        hatView.transform = CGAffineTransform(rotationAngle: angle)
    }

    func update(leftEye: [CGPoint], rightEye: [CGPoint]) {
        self.leftEye = leftEye
        self.rightEye = rightEye
        self.setNeedsDisplay()
    }
}


