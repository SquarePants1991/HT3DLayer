//
// Created by yang wang on 2017/12/22.
// Copyright (c) 2017 ocean. All rights reserved.
//

import GLKit

public class HT3DGeometry {
    public var elements: [HT3DElement]?
    public var materials: [HT3DMaterial] = []
    public var modelMatrix: GLKMatrix4 = GLKMatrix4Identity
    public var material: HT3DMaterial? {
        return materials.first
    }

    public init(elements: [HT3DElement], material: HT3DMaterial) {
        self.elements = elements
        self.materials.append(material)
        self.setMaterialForElementsInRange(range: Range<Int>.init(uncheckedBounds: (0, elements.count - 1)), materialIndex: 0)
    }

    public init(elements: [HT3DElement], materials: [HT3DMaterial]) {
        self.elements = elements
        self.materials = materials
        self.setMaterialForElementsInRange(range: Range<Int>.init(uncheckedBounds: (0, elements.count - 1)), materialIndex: 0)
    }

    public func setMaterialForElementsInRange(range: Range<Int>, materialIndex: Int) {
        if let material = materials[cycle: materialIndex] {
            for index in range.lowerBound...range.upperBound {
                if let element = self.elements?[safe: index] {
                    var ele = element
                    ele.material = material
                    self.elements?[index] = ele
                }
            }
        }
    }
}