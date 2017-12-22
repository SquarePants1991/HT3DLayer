//
//  ViewController.swift
//  CA3D
//
//  Created by yang wang on 2017/12/20.
//  Copyright © 2017 ocean. All rights reserved.
//

import UIKit
import GLKit
import HT3DLayer

class ViewController: UIViewController {
    
    var elapsedTime: TimeInterval = 0
    var lastTimeStamp: TimeInterval = 0
    lazy var shapeLayer: HT3DCGLayer = HT3DCGLayer()
    var geometry1: HT3DGeometry!
    var geometry2: HT3DGeometry!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var material1 = HT3DMaterial.default()
        material1.diffuse = GLKVector3.init(v: (1, 0, 0))
        var material2 = HT3DMaterial.default()
        material2.diffuse = GLKVector3.init(v: (0, 1, 0))
        var material3 = HT3DMaterial.default()
        material3.diffuse = GLKVector3.init(v: (0, 0, 1))
        
        let cubePoints: [GLKVector3] = cube()
        geometry1 = HT3DGeometry.init(elements: HT3DPolygonElement.createElementsFromQuads(points: cubePoints), materials: [material1, material2, material3])
        geometry1.setMaterialForElementsInRange(range: Range<Int>.init(uncheckedBounds: (1, 1)), materialIndex: 1)
        geometry1.setMaterialForElementsInRange(range: Range<Int>.init(uncheckedBounds: (2, 2)), materialIndex: 2)
        geometry1.setMaterialForElementsInRange(range: Range<Int>.init(uncheckedBounds: (3, 3)), materialIndex: 1)
        geometry1.setMaterialForElementsInRange(range: Range<Int>.init(uncheckedBounds: (4, 4)), materialIndex: 2)
        geometry1.setMaterialForElementsInRange(range: Range<Int>.init(uncheckedBounds: (5, 5)), materialIndex: 1)
        
        let conePoints: [GLKVector3] = cone()
        geometry2 = HT3DGeometry.init(elements: HT3DPolygonElement.createElementsFromTriangles(points: conePoints), materials: [material1, material2, material3])
        for i in 0..<(geometry2.elements?.count ?? 0) {
            geometry2.setMaterialForElementsInRange(range: Range<Int>.init(uncheckedBounds: (i, i)), materialIndex: i)
        }
        
        let displayLink = CADisplayLink.init(target: self, selector: #selector(ticked(displayLink:)))
        displayLink.add(to: RunLoop.main, forMode: .commonModes)
        lastTimeStamp = displayLink.timestamp
        
        self.view.layer.addSublayer(shapeLayer)
        shapeLayer.frame = self.view.bounds
        
        shapeLayer.addGeometry(geometry: geometry1)
        shapeLayer.addGeometry(geometry: geometry2)
    }
    
    @objc func ticked(displayLink: CADisplayLink) {
        elapsedTime += displayLink.timestamp - lastTimeStamp
        lastTimeStamp = displayLink.timestamp
        geometry1.modelMatrix = GLKMatrix4MakeRotation(Float(elapsedTime * 3), 1, 1, 1)
        geometry1.modelMatrix = GLKMatrix4MakeTranslation(-1, 0, -1) * geometry1.modelMatrix
        
        geometry2.modelMatrix = GLKMatrix4MakeRotation(Float(elapsedTime * 3), 1, 1, 1)
        geometry2.modelMatrix = GLKMatrix4MakeTranslation(1, 0, -1) * geometry2.modelMatrix
        shapeLayer.viewMatrix = GLKMatrix4MakeLookAt(0, 0, Float(1 * sin(elapsedTime) + 4), 0, 0, 0, 0, 1, 0)
        
        shapeLayer.doRender()
    }
    
    func cone() -> [GLKVector3] {
        return [
            GLKVector3.init(v: (0, 0.5, 0)),
            GLKVector3.init(v: (0.5, -0.5, 0.5)),
            GLKVector3.init(v: (0, -0.5, -0.5)),
            
            GLKVector3.init(v: (0, 0.5, 0)),
            GLKVector3.init(v: (0, -0.5, -0.5)),
            GLKVector3.init(v: (-0.5, -0.5, 0.5)),
            
            GLKVector3.init(v: (0, 0.5, 0)),
            GLKVector3.init(v: (-0.5, -0.5, 0.5)),
            GLKVector3.init(v: (0.5, -0.5, 0.5)),
            
            GLKVector3.init(v: (-0.5, -0.5, 0.5)),
            GLKVector3.init(v: (0.5, -0.5, 0.5)),
            GLKVector3.init(v: (0, -0.5, -0.5)),
        ]
    }
    
    func cube() -> [GLKVector3] {
        return [
            GLKVector3.init(v: (0.5, -0.5, 0.5)),
            GLKVector3.init(v: (0.5, -0.5, -0.5)),
            GLKVector3.init(v: (0.5, 0.5, -0.5)),
            GLKVector3.init(v: (0.5, 0.5, 0.5)),
            
            GLKVector3.init(v: (-0.5, -0.5, 0.5)),
            GLKVector3.init(v: (-0.5, -0.5, -0.5)),
            GLKVector3.init(v: (-0.5, 0.5, -0.5)),
            GLKVector3.init(v: (-0.5, 0.5, 0.5)),
            
            GLKVector3.init(v: (-0.5, 0.5, 0.5)),
            GLKVector3.init(v: (-0.5, 0.5, -0.5)),
            GLKVector3.init(v: (0.5, 0.5, -0.5)),
            GLKVector3.init(v: (0.5, 0.5, 0.5)),
            
            GLKVector3.init(v: (-0.5, -0.5, 0.5)),
            GLKVector3.init(v: (-0.5, -0.5, -0.5)),
            GLKVector3.init(v: (0.5, -0.5, -0.5)),
            GLKVector3.init(v: (0.5, -0.5, 0.5)),
            
            GLKVector3.init(v: (-0.5, 0.5, 0.5)),
            GLKVector3.init(v: (-0.5, -0.5, 0.5)),
            GLKVector3.init(v: (0.5, -0.5, 0.5)),
            GLKVector3.init(v: (0.5, 0.5, 0.5)),
            
            GLKVector3.init(v: (-0.5, 0.5, -0.5)),
            GLKVector3.init(v: (-0.5, -0.5, -0.5)),
            GLKVector3.init(v: (0.5, -0.5, -0.5)),
            GLKVector3.init(v: (0.5, 0.5, -0.5)),
        ]
    }
    
    
    
}
