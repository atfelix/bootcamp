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
    @IBOutlet weak var stretchyNavigationBarView: UIView!
    var stackView : UIStackView!
    var isStretched = false
    private var stackViewOriginalFrame: CGRect!
    private var stackViewStretchedFrame: CGRect!

    override func viewDidLoad() {
        super.viewDidLoad()

        addStackView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func plusButtonTapped(_ sender: UIButton) {
        animateConstraints(sender, newConstant: (isStretched) ? 64 : 200)
        isStretched = !isStretched
    }

    private func addStackView() {
        let imageNames = ["oreos.png", "pizza_pockets.png", "pop_tarts.png", "popsicle.png", "ramen.png"]
        stackViewOriginalFrame = CGRect(x: 0, y: 50, width: view.bounds.width, height: 0)
        stackViewStretchedFrame = CGRect(x: 0, y: 50, width: view.bounds.width, height: 200 - 50)
        stackView = UIStackView(frame: stackViewOriginalFrame)
        stackView.distribution = .fillEqually
        for i in 0..<5 {
            stackView.addArrangedSubview(UIImageView(image: UIImage(named: imageNames[i])))
        }
        stretchyNavigationBarView.addSubview(stackView)
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

                           self.stackView.frame = (self.isStretched) ? self.stackViewOriginalFrame : self.stackViewStretchedFrame
                           sender.transform = sender.transform.rotated(by: CGFloat.pi / 4)
                           self.view.layoutIfNeeded()
        },
                       completion:nil)
    }


}
