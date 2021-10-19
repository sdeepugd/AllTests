//
//  MaskLayerTest.swift
//  AllTests
//
//  Created by Deepak Srinivasan on 15/10/21.
//

import UIKit

class MaskLayerTest :UIViewController
{
    var imageLayerView:UIImageView = {
        let imageLayerView = UIImageView(image: UIImage(named: "CAGradientLayer"))
        return imageLayerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageLayerView)
        imageLayerView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
        let maskLayer = CALayer()
        maskLayer.frame = imageLayerView.bounds
        let image = UIImage(named: "CALayer")
        maskLayer.contents = image?.cgImage
        
        imageLayerView.layer.mask = maskLayer
    }
}
