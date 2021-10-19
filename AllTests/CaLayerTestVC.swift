//
//  CaLayerTestVC.swift
//  AllTests
//
//  Created by Deepak Srinivasan on 14/10/21.
//

import UIKit

class CaLayerTestVC:UIViewController {
    
    let swiftOrangeColor = UIColor(red: 248 / 255.0, green: 96 / 255.0, blue: 47 / 255.0, alpha: 1.0)
    
    let mainView = UIView()

    enum centreGravity:String,CaseIterable {
        case centre = "centre"
        case top = "top"
        case bottom = "bottom"
        case left = "left"
        case right = "right"
        case topleft = "topleft"
        case topRight = "topRight"
        case bottomLeft = "bottomLeft"
        case bottomRight = "bottomRight"
        case resize = "resize"
        case resizeAspect = "resizeAspect"
        case resizeAspectFill = "resizeAspectFill"
        
        func getCALayerContentsGravity() -> CALayerContentsGravity {
            switch (self) {
            case .centre:
                return CALayerContentsGravity.center
            case .top:
                return CALayerContentsGravity.top
            case .bottom:
                return CALayerContentsGravity.bottom
            case .left:
                return CALayerContentsGravity.left
            case .right:
                return CALayerContentsGravity.right
            case .topleft:
                return CALayerContentsGravity.topLeft
            case .topRight:
                return CALayerContentsGravity.topRight
            case .bottomLeft:
                return CALayerContentsGravity.bottomLeft
            case .bottomRight:
                return CALayerContentsGravity.bottomRight
            case .resize:
                return CALayerContentsGravity.resize
            case .resizeAspect:
                return CALayerContentsGravity.resizeAspect
            case .resizeAspectFill:
                return CALayerContentsGravity.resizeAspectFill
            }
        }
    }
    let crentreGravityDS = centreGravity.allCases
    let layer = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "CaLayerTestVC"
        view.addSubview(mainView)
        view.backgroundColor = .yellow
        let viewBounds = view.bounds
        let viewFrame = view.frame
        print("bounds:\(viewBounds)")
        print("frame:\(viewFrame)")
        mainView.frame = CGRect(x: (viewBounds.width/2)-(viewBounds.width/6), y: 100, width: (viewBounds.width/3), height: viewBounds.height/4)
        setUpLayer()
        mainView.layer.addSublayer(layer)
        
        let optionsStack = UIStackView()
        optionsStack.axis = .vertical
        optionsStack.alignment = .leading
        optionsStack.backgroundColor = .gray
        optionsStack.frame = CGRect(x: 20, y: viewBounds.height/2, width: viewBounds.width-40, height: viewBounds.height/2)
        
        let gradeTextField = UITextField()
        let gradePicker = UIPickerView()
        gradePicker.dataSource = self
        gradePicker.delegate = self
        
        gradeTextField.inputView = gradePicker
        gradeTextField.text = crentreGravityDS[0].rawValue
        optionsStack.addArrangedSubview(gradeTextField)
        
        let opacityStackView = UIStackView()
        opacityStackView.backgroundColor = .gray
        opacityStackView.axis = .horizontal
        let opacityLabel = UILabel()
        opacityLabel.text = "Opacity"
        let opacitySlider = UISlider(frame: CGRect(x: 100, y: 500, width: 300, height: 100))
        
        opacitySlider.minimumValue = 0
        opacitySlider.maximumValue = 1
        opacitySlider.isContinuous = true
        opacitySlider.tintColor = .blue
        opacitySlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
//        opacityStackView.addArrangedSubview(opacityLabel)
//        opacityStackView.addArrangedSubview(opacitySlider)
        
//        optionsStack.addArrangedSubview(opacityStackView)
        view.addSubview(opacitySlider)
//        view.addSubview(optionsStack)
    }
    
    @objc func sliderValueChanged(_ sender:UISlider!) {
        layer.opacity = sender.value
    }
}

extension CaLayerTestVC {
  func setUpLayer() {
    //1
    layer.frame = mainView.bounds
    layer.contents = UIImage(named: "star")?.cgImage

    // 2
    layer.contentsGravity = .center
    layer.magnificationFilter = .linear

    // 3
    layer.cornerRadius = 100.0
    layer.borderWidth = 12.0
    layer.borderColor = UIColor.white.cgColor
    layer.backgroundColor = swiftOrangeColor.cgColor

    //4
    layer.shadowOpacity = 0.75
    layer.shadowOffset = CGSize(width: 0, height: 3)
    layer.shadowRadius = 3.0
    layer.isGeometryFlipped = false
  }
}

extension CaLayerTestVC : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        crentreGravityDS.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        crentreGravityDS[row].rawValue
    }
    
}

extension CaLayerTestVC :UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        layer.contentsGravity = crentreGravityDS[row].getCALayerContentsGravity()
    }
}
