//
//  ViewController.swift
//  AppleWatchTestApp
//
//  Created by Enkhjargal Gansukh on 06/03/2018.
//  Copyright © 2018 Enkhjargal Gansukh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func startMotionScene(_ sender: Any) {
        let motionScene = self.storyboard?.instantiateViewController(withIdentifier: "MotionScene")
        if motionScene != nil {
            self.present(motionScene!, animated: true, completion: nil)
        }
    }
}

