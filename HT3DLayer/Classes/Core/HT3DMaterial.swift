//
// Created by yang wang on 2017/12/22.
// Copyright (c) 2017 ocean. All rights reserved.
//

import GLKit
import UIKit

public struct HT3DMaterial {
    public var diffuse: GLKVector3
    public var lineColor: GLKVector3
    public var lineWidth: CGFloat

    public static func `default`() -> HT3DMaterial {
        return HT3DMaterial.init(diffuse: GLKVector3.init(v: (0.2, 0.2, 0.2)), lineColor: GLKVector3.init(v: (0.2, 0.2, 0.2)), lineWidth: 1)
    }
}