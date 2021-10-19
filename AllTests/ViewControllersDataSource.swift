//
//  ViewControllersDataSource.swift
//  AllTests
//
//  Created by Deepak Srinivasan on 14/10/21.
//

import UIKit

struct ViewControllerData {
    let displayname:String
    let viewController:UIViewController
}

class ViewControllerDataSource
{
    public static let vcs :[ViewControllerData] = [
        ViewControllerData(displayname: "CaLayerTestVC", viewController: CaLayerTestVC()),
        ViewControllerData(displayname: "MaskLayerTest", viewController: MaskLayerTest()),
        ViewControllerData(displayname: "AffineTransformTest", viewController: AffineTransformTest()),
        ViewControllerData(displayname: "RotationTransformTest", viewController: RotationTransformTest()),
        ViewControllerData(displayname: "CubeUsingTransform", viewController: CubeUsingTransform()),
        ViewControllerData(displayname: "CollectionViewInTableViewTest", viewController: CollectionViewInTableViewTest())
    ]
}
