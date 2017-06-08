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
    var isStretched = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(stretchyHeaderHeightConstraint.constant)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func plusButtonTapped(_ sender: UIButton) {
        animateConstraints(sender, newConstant: (isStretched) ? 64 : 200)
        isStretched = !isStretched
    }

    private func animateConstraints(_ sender: UIButton, newConstant: CGFloat) {
        self.stretchyHeaderHeightConstraint.constant = newConstant
        view.setNeedsUpdateConstraints()

        UIView.animate(withDuration: 1.3,
                       delay: 0.0,
                       usingSpringWithDamping: 0.33,
                       initialSpringVelocity: 0.7,
                       options: [.curveEaseInOut],
                       animations: {
                           sender.transform = sender.transform.rotated(by: CGFloat.pi / 4)
                           self.view.layoutIfNeeded()
        },
                       completion: nil)
    }
}
