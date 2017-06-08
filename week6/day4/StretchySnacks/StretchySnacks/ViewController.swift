//
//  ViewController.swift
//  StretchySnacks
//
//  Created by atfelix on 2017-06-08.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var stretchyHeaderHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var stretchyNavigationBarView: UIView!
    @IBOutlet weak var tableView: UITableView!

    var snacks = [String]()
    var stackView : UIStackView!
    var isStretched = false

    private var stackViewOriginalFrame: CGRect!
    private var stackViewStretchedFrame: CGRect!

    override func viewDidLoad() {
        super.viewDidLoad()

        addStackView()
    }

    @IBAction func plusButtonTapped(_ sender: UIButton) {
        animateConstraints(sender, newConstant: (isStretched) ? 64 : 200)
        isStretched = !isStretched
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snacks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SnackCell", for: indexPath)
        cell.textLabel?.text = snacks[indexPath.row]

        return cell
    }

    private func addStackView() {
        let imageNames = ["oreos.png", "pizza_pockets.png", "pop_tarts.png", "popsicle.png", "ramen.png"]
        stackViewOriginalFrame = CGRect(x: 0, y: 50, width: view.bounds.width, height: 0)
        stackViewStretchedFrame = CGRect(x: 0, y: 70, width: view.bounds.width, height: 120)
        stackView = UIStackView(frame: stackViewOriginalFrame)
        stackView.distribution = .fillEqually
        stackView.isUserInteractionEnabled = true
        for i in 0..<5 {
            stackView.addArrangedSubview(imageViewWithTapGR(imageName: imageNames[i]))
        }
        stretchyNavigationBarView.addSubview(stackView)
    }

    private func animateConstraints(_ sender: UIButton, newConstant: CGFloat) {
        self.stretchyHeaderHeightConstraint.constant = newConstant
        view.setNeedsUpdateConstraints()
        changeSnackTitleConstraint()

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

    private func changeSnackTitleConstraint() {
        for view in view.subviews {
            for constraint in view.constraints {
                if constraint.identifier == "centerYSnackTitle" {
                    let label = constraint.firstItem as! UILabel
                    label.text = (isStretched) ? "SNACKS" : "Add a Snack"
                    constraint.isActive = false
                    constraint.constant -= (isStretched) ? -40 : 40
                    constraint.isActive = true
                }
            }
        }
    }

    private func imageViewWithTapGR(imageName: String) -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.isUserInteractionEnabled = true
        addTapGestureRecognizer(to: imageView)
        return imageView
    }

    private func addTapGestureRecognizer(to imageView: UIImageView) {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(ViewController.addSnack(_:)))
        imageView.addGestureRecognizer(tapGR)
    }

    func addSnack(_ sender: UITapGestureRecognizer) {
        let names = ["Oreos", "Pizza Pockets", "Pop Tarts", "Popsicle", "Ramen"]
        let imageView = sender.view as! UIImageView
        for (i, view) in stackView.arrangedSubviews.enumerated() {
            if view === imageView {
                snacks.append(names[i])
                tableView.reloadData()
                return
            }
        }
    }
}
