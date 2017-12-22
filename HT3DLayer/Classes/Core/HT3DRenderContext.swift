//
// Created by yang wang on 2017/12/20.
// Copyright (c) 2017 ocean. All rights reserved.
//

import GLKit
import UIKit

protocol HT3DRenderContext {
    func render(elements: [HT3DElement])
}

extension HT3DRenderContext {
    public func render(vpMatrix: GLKMatrix4, geometries: [HT3DGeometry]) {
        var elements: [HT3DElement] = []
        for geometry in geometries {
            let _ = geometry.elements?.map {
                elements.append($0.transform(matrix: vpMatrix * geometry.modelMatrix))
            }
        }
        elements.sort { $0.sortZRef() > $1.sortZRef() }
        render(elements: elements)
    }
}
