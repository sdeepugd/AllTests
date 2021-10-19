//
//  RotationTransformTest.swift
//  AllTests
//
//  Created by Deepak Srinivasan on 17/10/21.
//
import UIKit
import GLKit

class CubeUsingTransform :UIViewController
{
    
    let containerView:UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    var faces = [UIView]()
    let faceColor = [UIColor.blue,UIColor.green,UIColor.yellow,UIColor.red,UIColor.cyan ,UIColor.magenta]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let vwidth = view.bounds.width
        containerView.frame = CGRect(x: 0, y: 0, width: vwidth, height: vwidth)
        containerView.backgroundColor = .white
        view.addSubview(containerView)

        for _ in 0...5
        {
            let face = UIView()
            face.backgroundColor = .gray
            setDefaultFrame(face)
            faces.append((face))
        }
        
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0/500.0
        perspective = CATransform3DRotate(perspective, -Double.pi/4, 1, 0, 0)
        perspective = CATransform3DRotate(perspective, (Double.pi/4), 0, 1, 0)
        containerView.layer.sublayerTransform = perspective
        
        var transform = CATransform3DMakeTranslation(0, 0, 100)
        addFace(index: 0, transform: transform)
        
        transform = CATransform3DMakeTranslation(100, 0, 0)
        transform = CATransform3DRotate(transform, Double.pi/2, 0, 1, 0)
        addFace(index: 1, transform: transform)
        
        transform = CATransform3DMakeTranslation(-100, 0, 0)
        transform = CATransform3DRotate(transform, -Double.pi/2, 0, 1, 0)
        addFace(index: 2, transform: transform)
        
        transform = CATransform3DMakeTranslation(0, 100, 0)
        transform = CATransform3DRotate(transform, Double.pi/2, 1, 0, 0)
        addFace(index: 3, transform: transform)
        
        transform = CATransform3DMakeTranslation(0, -100, 0)
        transform = CATransform3DRotate(transform, -Double.pi/2, 1, 0, 0)
        addFace(index: 4, transform: transform)
        
        transform = CATransform3DMakeTranslation(0, 0, -100)
        transform = CATransform3DRotate(transform, Double.pi, 0, 1, 0)
        addFace(index: 5, transform: transform)
        
    }
    
    func applyLighting(face:CALayer){
        let layer = CALayer()
        layer.frame = face.bounds
        face.addSublayer(layer)
        let transform = face.transform
        let matrix4 = getMatrix4WithTranform(transform: transform)
        let matrix3 = GLKMatrix4GetMatrix3(matrix4)
        
        var  normal = GLKVector3Make(0, 0, 1)
        normal = GLKMatrix3MultiplyVector3(matrix3, normal)
        normal = GLKVector3Normalize(normal)
        
        let light = GLKVector3Normalize(GLKVector3Make(0, 1, -0.5))
        let dotProduct = GLKVector3DotProduct(light, normal)
        
        let shadow = 1 + dotProduct - 0.5
        let color = UIColor(white: 0, alpha: CGFloat(shadow))
        layer.backgroundColor = color.cgColor
    }
    
    func getMatrix4WithTranform(transform:CATransform3D) ->GLKMatrix4 {
        return GLKMatrix4Make(Float(transform.m11), Float(transform.m12), Float(transform.m13), Float(transform.m14), Float(transform.m21), Float(transform.m22), Float(transform.m23), Float(transform.m24), Float(transform.m31), Float(transform.m32), Float(transform.m33), Float(transform.m34), Float(transform.m41), Float(transform.m42), Float(transform.m43), Float(transform.m44))
    }
    
    func addFace(index:Int,transform:CATransform3D)
    {
        let face = faces[index]
        containerView.addSubview(face)
        
        let containerSize = containerView.bounds.size
        face.center = CGPoint(x: containerSize.width / 2.0, y: containerSize.height / 2.0)
        
        face.layer.transform = transform
        
        applyLighting(face: face.layer)
    }
    
    func setDefaultFrame(_ face:UIView){
        let vwidth = view.bounds.width
        let vheight = view.bounds.height
        face.frame = CGRect(x: vwidth/4, y: vheight/4, width: vwidth/2, height: vwidth/2)
    }
}
