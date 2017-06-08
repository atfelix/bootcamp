//
//  ViewController.swift
//  StretchySnacks
//
//  Created by atfelix on 2017-06-08.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stretchyHeaderHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func plusButtonTapped(_ sender: UIButton) {
        self.stretchyHeaderHeightConstraint.constant = 200
        view.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
}
