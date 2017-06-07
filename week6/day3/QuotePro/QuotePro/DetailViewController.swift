//
//  DetailViewController.swift
//  QuotePro
//
//  Created by atfelix on 2017-06-07.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

import UIKit

protocol QuoteDelegate: class {
    func saveQuote(quoteString: String?, quoteAuthor: String?, image: UIImage?)
}

class DetailViewController: UIViewController {

    var quoteView: QuoteView!
    var delegate: QuoteDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        quoteView = Bundle.main.loadNibNamed("QuoteView", owner: nil, options: nil)?.first as! QuoteView
        view = quoteView
        quoteView.imageButton.addTarget(self, action: #selector(DetailViewController.imageTapped(_:)), for: .touchUpInside)
        quoteView.quoteButton.addTarget(self, action: #selector(DetailViewController.quoteTapped(_:)), for: .touchUpInside)
        quoteView.saveButton.addTarget(self, action: #selector(DetailViewController.saveTapped(_:)), for: .touchUpInside)
        quoteView.authorLabel.text = "Quote goes here"
        quoteView.quoteLabel.text = "Author goes here"
    }

    func imageTapped(_ sender: UIButton) {
        fetchImage()
    }

    func quoteTapped(_ sender: UIButton) {
        fetchQuote()
    }

    func saveTapped(_ sender: UIButton) {
        delegate.saveQuote(quoteString: quoteView.quoteLabel.text ?? "", quoteAuthor: quoteView.authorLabel.text ?? "", image: quoteView.imageView.image)
    }

    @IBAction func shareQuote(_ sender: UIBarButtonItem) {
        guard let image = UIImage.snapshot(view: quoteView) else {
            return
        }
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }

    private func fetchImage() {
        NetworkManager.fetchImage {[weak self] (image: UIImage?) in
            guard let image = image else {
                print(#line, "no image")
                return
            }
            guard let weakSelf = self else {
                return
            }
            OperationQueue.main.addOperation {
                weakSelf.quoteView.imageView.image = image
            }
        }
    }

    private func fetchQuote() {
        NetworkManager.fetchQuote {[weak self] (quoteText, quoteAuthor) in
            guard
                let quoteText = quoteText,
                let quoteAuthor = quoteAuthor else {
                    return
            }

            guard let weakSelf = self else {
                return
            }
            OperationQueue.main.addOperation {
                weakSelf.quoteView.quoteLabel.text = quoteText
                weakSelf.quoteView.authorLabel.text = quoteAuthor
            }
        }
    }
}

extension UIImage {
    static func snapshot(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
