//
//  PlaceAnnotationNode.swift
//  renovacionARZoo
//
//  Created by Kike on 13/3/18.
//  Copyright © 2018 Kike. All rights reserved.
//

import Foundation
import ARCL
import CoreLocation
import SceneKit
import MapKit

class PlaceAnnotationNode: LocationNode {
    var title: String
    var annotationNode: SCNNode
    
    init(location: CLLocation?, title: String){
        self.annotationNode = SCNNode()
        self.title = title
        super.init(location: location)
        
        initializeUI()
    }
    
    private func center(node: SCNNode){
        let(min, max) = node.boundingBox
        let dx = min.x + 0.5 * (max.x - min.x)
        let dy = min.y + 0.5 * (max.y - min.y)
        let dz = min.z + 0.5 * (max.z - min.z)
        node.pivot = SCNMatrix4MakeTranslation(dx, dy, dz)
    }
    
    
    private func initializeUI(){
        let plane = SCNPlane(width: 10, height: 5)
        plane.cornerRadius = 15
        plane.firstMaterial?.diffuse.contents = UIColor.green
        
        print("THERE")
        let text = SCNText(string: self.title, extrusionDepth: 0)
        text.containerFrame = CGRect(x: 0, y: 0, width: 5, height: 3)
        text.isWrapped = true
        text.font = UIFont(name: "Futura", size: 0.7)
        text.alignmentMode = kCAAlignmentCenter
        text.truncationMode = kCATruncationMiddle
        text.firstMaterial?.diffuse.contents = UIColor.black
        
        let textNode = SCNNode(geometry: text)
        textNode.position = SCNVector3(0, 0, 0.2)
        center(node: textNode)
        
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.addChildNode(textNode)
        
        self.annotationNode.scale = SCNVector3(3,3,3)
        self.annotationNode.addChildNode(planeNode)
        
        let billBoardConstraint = SCNBillboardConstraint()
        billBoardConstraint.freeAxes = SCNBillboardAxis.Y
        constraints = [billBoardConstraint]
        
        self.addChildNode(self.annotationNode)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
