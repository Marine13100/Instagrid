//
//  ViewController.swift
//  Instagrid
//
//  Created by Marine Bernard on 23/04/2020.
//  Copyright © 2020 Marine Bernard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - outlets
    
    @IBOutlet var plusButtons: [UIButton]!
    @IBOutlet var layoutButtons: [UIButton]!
    
    // MARK: - Properties
    
    private let imagePickerController = UIImagePickerController()
    private var selectedPlusButton: UIButton?
    
    // MARK: - view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
    }

    // MARK: - actions
    
    @IBAction func layoutButtonTapped(_ sender: UIButton) {
        for button in layoutButtons {
            button.isSelected = false
        }
        sender.isSelected = true
        switch sender.tag {
        case 0:
            plusButtons[1].isHidden = true
            plusButtons[3].isHidden = false
        case 1:
            plusButtons[1].isHidden = false
            plusButtons[3].isHidden = true
        case 2:
            plusButtons[1].isHidden = false
            plusButtons[3].isHidden = false
        default: break
        }
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        selectedPlusButton = sender
        present(imagePickerController, animated: true)
    }
}

// MARK: - selection and display of the image of the central grid buttons

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        selectedPlusButton?.setImage(selectedImage, for: .normal)
        dismiss(animated: true)
    }
}
