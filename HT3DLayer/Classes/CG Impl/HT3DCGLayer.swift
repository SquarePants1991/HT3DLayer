//
// Created by yang wang on 2017/12/21.
// Copyright (c) 2017 ocean. All rights reserved.
//

import QuartzCore
import GLKit

public class HT3DCGLayer: CALayer {
    public var viewMatrix: GLKMatrix4 = GLKMatrix4MakeLookAt(0, 0, 4, 0, 0, 0, 0, 1, 0)
    public var projectionMatrix: GLKMatrix4 = GLKMatrix4Identity

    lazy var renderContext: HT3DCGRenderContext = HT3DCGRenderContext()

    private var geometries: [HT3DGeometry] = []

    open override func layoutSublayers() {
        super.layoutSublayers()
        let aspect = Float(self.bounds.size.width / self.bounds.size.height)
        self.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(90.0), aspect, 0.1, 1000)
    }

    open override func draw(in ctx: CGContext) {
        renderContext.currentCGContext = ctx
        renderContext.canvasSize = self.frame.size

        let vp = projectionMatrix * viewMatrix
        renderContext.render(vpMatrix: vp, geometries: self.geometries)
    }

    open func addGeometry(geometry: HT3DGeometry) {
        self.geometries.append(geometry)
    }

    open func doRender() {
        self.setNeedsDisplay()
    }
}