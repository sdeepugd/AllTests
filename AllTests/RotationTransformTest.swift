//
//  RotationTransformTest.swift
//  AllTests
//
//  Created by Deepak Srinivasan on 17/10/21.
//
import UIKit

class RotationTransformTest :UIViewController
{
    var outerView:UIView = {
        let outerView = UIView()
        outerView.backgroundColor = .gray
        return outerView
    }()
    
    var innerView:UIView = {
        let innerView = UIView()
        innerView.backgroundColor = .magenta
        return innerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(outerView)
        let vwidth = view.bounds.width
        let vheight = view.bounds.height
        outerView.frame = CGRect(x: vwidth/4, y: vheight/4, width: vwidth/2, height: vwidth/2)
        
        var outer = CATransform3DIdentity
//        outer.m34 = -1.0/500.0
        outer = CATransform3DRotate(outer, Double.pi / 4, 0, 0, 1)
        outerView.layer.transform = outer
        
        outerView.addSubview(innerView)
        let owidth = outerView.bounds.width
        let oheight = outerView.bounds.height
        innerView.frame = CGRect(x: owidth/4, y: oheight/4, width: owidth/2, height: owidth/2)
        
        var inner = CATransform3DIdentity
//        inner.m34 = -1.0/500.0
        inner = CATransform3DRotate(inner, -Double.pi / 4, 0, 0, 1)
        innerView.layer.transform = inner
    }
}
