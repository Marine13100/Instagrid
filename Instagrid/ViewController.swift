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
    @IBOutlet weak var gridView: UIView!
    
    // MARK: - Properties
    
    private let imagePickerController = UIImagePickerController()
    private var selectedPlusButton: UIButton?
    private var swipeGestureRecognizer: UISwipeGestureRecognizer?
    
    
    
    // MARK: - view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwipeDirection()
        NotificationCenter.default.addObserver(self, selector: #selector(setupSwipeDirection), name: UIDevice.orientationDidChangeNotification, object: nil)
        imagePickerController.delegate = self
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        guard let swipeGestureRecognizer = swipeGestureRecognizer else { return }
        swipeGestureRecognizer.direction = .up
        gridView.addGestureRecognizer(swipeGestureRecognizer)
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
    
    @objc
    private func setupSwipeDirection() {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            swipeGestureRecognizer?.direction = .left
        } else {
            swipeGestureRecognizer?.direction = .up
        }
        
    }
    
    @objc
    private func swipeAction() {
        if swipeGestureRecognizer?.direction == .up {
            UIView.animate(withDuration: 0.5, animations: {
                self.gridView.transform = CGAffineTransform(translationX: 0, y: -1000)
                
            }, completion: { _ in
                self.share()
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.gridView.transform = CGAffineTransform(translationX: -1000, y: 0)
                
            }, completion: { _ in
                self.share()
            })
        }
        
    }
    
    func share() {
        // UIActivityViewController, trouver comment gtransformer uner vu en image
        UIView.animate(withDuration: 0.5) {
            self.gridView.transform = .identity
        }
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

