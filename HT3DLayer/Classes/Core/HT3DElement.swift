//
// Created by yang wang on 2017/12/20.
// Copyright (c) 2017 ocean. All rights reserved.
//

import GLKit
import UIKit

public protocol HT3DElement {
    var material: HT3DMaterial { get set }
    func transform(matrix: GLKMatrix4) -> Self
    func sortZRef() -> Float
}

public struct HT3DLineElement: HT3DElement {

    public var startPoint: GLKVector3
    public var endPoint: GLKVector3
    public var material: HT3DMaterial

    public func transform(matrix: GLKMatrix4) -> HT3DLineElement {
        let newStartPoint = matrix * GLKVector4.init(vector3: startPoint, w: 1)
        let newEndPoint = matrix * GLKVector4.init(vector3: endPoint, w: 1)
        return HT3DLineElement.init(startPoint: (newStartPoint / newStartPoint.w).xyz, endPoint: (newEndPoint
                / newEndPoint.w).xyz, material: material)
    }

    public func sortZRef() -> Float {
        return (startPoint.z + endPoint.z) / 2.0
    }

    public static func createElementsFromLineStrip(points: [GLKVector3], closeLine: Bool = false) -> [HT3DLineElement] {
        var elements: [HT3DLineElement] = []
        for index in 0..<points.count {
            if let beginPoint = points[safe: index], let endPoint = points[safe: index + 1] {
                let element = HT3DLineElement.init(startPoint: beginPoint, endPoint: endPoint, material: HT3DMaterial.default())
                elements.append(element)
            }
        }
        if closeLine, let firstPoint = points.first, let lastPoint = points.last {
            let element = HT3DLineElement.init(startPoint: lastPoint, endPoint: firstPoint, material: HT3DMaterial.default())
            elements.append(element)
        }
        return elements
    }

    public static func createElementsFromTriangles(points: [GLKVector3]) -> [HT3DLineElement] {
        var elements: [HT3DLineElement] = []
        for index in stride(from: 0, through: points.count, by: 3) {
            if let beginPoint = points[safe: index],
               let centerPoint = points[safe: index + 1],
               let endPoint = points[safe: index + 2] {
                elements.append(HT3DLineElement.init(startPoint: beginPoint, endPoint: centerPoint, material: HT3DMaterial.default()))
                elements.append(HT3DLineElement.init(startPoint: beginPoint, endPoint: endPoint, material: HT3DMaterial.default()))
                elements.append(HT3DLineElement.init(startPoint: centerPoint, endPoint: endPoint, material: HT3DMaterial.default()))
            }
        }
        return elements
    }
}

public struct HT3DPolygonElement: HT3DElement {

    public var points: [GLKVector3]
    public var isClosed: Bool = true
    public var material: HT3DMaterial

    public func transform(matrix: GLKMatrix4) -> HT3DPolygonElement {
        var newPoints: [GLKVector3] = []
        for point in points {
            let newPoint = matrix * GLKVector4.init(vector3: point, w: 1)
            newPoints.append((newPoint / newPoint.w).xyz)
        }
        return HT3DPolygonElement.init(points: newPoints, isClosed: isClosed, material: material)
    }

    public func sortZRef() -> Float {
        return points.reduce(0) {
            return $0 + $1.z
        } / Float(points.count)
    }

    public static func createElementsFromTriangles(points: [GLKVector3]) -> [HT3DPolygonElement] {
        var elements: [HT3DPolygonElement] = []
        for index in stride(from: 0, through: points.count, by: 3) {
            if let beginPoint = points[safe: index],
               let centerPoint = points[safe: index + 1],
               let endPoint = points[safe: index + 2] {
                let element = HT3DPolygonElement.init(points: [beginPoint, centerPoint, endPoint], isClosed: true, material: HT3DMaterial.default())
                elements.append(element)
            }
        }
        return elements
    }

    public static func createElementsFromQuads(points: [GLKVector3]) -> [HT3DPolygonElement] {
        var elements: [HT3DPolygonElement] = []
        for index in stride(from: 0, through: points.count, by: 4) {
            if let point1 = points[safe: index],
               let point2 = points[safe: index + 1],
               let point3 = points[safe: index + 2],
               let point4 = points[safe: index + 3] {
                let element = HT3DPolygonElement.init(points: [point1, point2, point3, point4], isClosed: true, material: HT3DMaterial.default())
                elements.append(element)
            }
        }
        return elements
    }
}