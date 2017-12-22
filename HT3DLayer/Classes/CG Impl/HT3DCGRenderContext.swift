//
// Created by yang wang on 2017/12/21.
// Copyright (c) 2017 ocean. All rights reserved.
//

import UIKit
import GLKit

class HT3DCGRenderContext: HT3DRenderContext {

    var currentCGContext: CGContext?
    var canvasSize: CGSize = CGSize.zero

    func render(elements: [HT3DElement]) {
        guard let context = currentCGContext else {
            return
        }
        for element in elements {
            (element as? HT3DLineElement).map {
                renderElement(context: context, element: $0)
            }
            (element as? HT3DPolygonElement).map {
                renderElement(context: context, element: $0)
            }
        }
    }

    func renderElement(context: CGContext, element: HT3DLineElement) {
        context.setStrokeColor(UIColor.fromVec3(glkVector3: element.material.lineColor).cgColor)
        context.setLineWidth(element.material.lineWidth)
        context.beginPath()
        context.move(to: convertCoordFromGLToCG(element.startPoint.cgPoint()))
        context.addLine(to: convertCoordFromGLToCG(element.endPoint.cgPoint()))
        context.strokePath()
    }

    func renderElement(context: CGContext, element: HT3DPolygonElement) {
        context.setFillColor(UIColor.fromVec3(glkVector3: element.material.diffuse).cgColor)
        context.setStrokeColor(UIColor.fromVec3(glkVector3: element.material.lineColor).cgColor)
        context.setLineWidth(element.material.lineWidth)

        context.beginPath()

        element.points.first.map { context.move(to: convertCoordFromGLToCG($0.cgPoint())) }
        for index in 1..<element.points.count {
            context.addLine(to: convertCoordFromGLToCG(element.points[index].cgPoint()))
        }
        if element.isClosed {
            context.closePath()
        }

        context.drawPath(using: .fillStroke)
    }


    func convertCoordFromGLToCG(_ from: CGPoint) -> CGPoint {
        return (from * (1, -1) + 1.0) * 0.5 * (canvasSize.width, canvasSize.height)
    }
}
