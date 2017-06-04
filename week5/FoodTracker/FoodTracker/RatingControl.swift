//
//  RatingControl.swift
//  FoodTracker
//
//  Created by atfelix on 2017-06-04.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }

    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    private func setupButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()

        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar.png", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar.png", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar.png", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount {
            let button = UIButton()

            let hintString: String? = (rating == index + 1) ? "Tap to reset rating to zero" : nil

            let valueString: String

            switch (rating) {
            case 0: valueString = "No rating yet"
            case 1: valueString = "1 star set"
            default: valueString = "\(rating) stars set"
            }

            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
            button.accessibilityLabel = "Set \(index + 1) star rating"

            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])

            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true

            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), for: .touchUpInside)
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }

    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }

    func ratingButtonTapped(_ sender: UIButton) {
        guard  let index = ratingButtons.index(of: sender) else {
            fatalError("The button \(sender) is not in the ratings button array")
        }

        let selectedIndex = index + 1
        rating = (selectedIndex == rating) ? 0 : selectedIndex
    }
}
