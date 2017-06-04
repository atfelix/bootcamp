//
//  ViewController.swift
//  FoodTracker
//
//  Created by atfelix on 2017-06-03.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var mealNameField: UITextField!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var meal: Meal?

    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MealViewController.selectedImageFromPhotoLibrary(_:))))
        updateSaveButtonState()

        if let meal = meal {
            navigationItem.title = meal.name
            mealNameField.text   = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func setLabelText(_ sender: UIButton) {
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }

    func selectedImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        mealNameField.resignFirstResponder()
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }

        let name = mealNameField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating

        meal = Meal.init(name: name, photo: photo, rating: rating)
    }

    private func updateSaveButtonState() {
        let text = mealNameField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        if presentingViewController is UINavigationController {
            dismiss(animated: true, completion: nil)
        }
        else if navigationController != nil {
            navigationController?.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
}
