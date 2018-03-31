//
//  MotionSceneController.swift
//  AppleWatchTestApp
//
//  Created by Enkhjargal Gansukh on 09/03/2018.
//  Copyright © 2018 Enkhjargal Gansukh. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class MotionSceneController: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    var scene: SCNScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSceneView(size: self.view.bounds)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
    }
    
    
    func initSceneView(size: CGRect){
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        let scene = SCNScene(named: "MotionScene.scn")
        sceneView.scene = scene
        let node = getBox()
        scene?.rootNode.addChildNode(node)
    }
    
    func getBox()-> SCNNode {
        let box = SCNBox(width: 0.5, height: 0.5, length: 1, chamferRadius: 0.0)
        let node = SCNNode()
        node.geometry = box
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        node.geometry?.firstMaterial?.specular.contents = UIColor.brown
        return node
    }

}
