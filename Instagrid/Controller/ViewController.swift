//
//  ViewController.swift
//  Instagrid
//
//  Created by Marine Bernard on 23/04/2020.
//  Copyright © 2020 Marine Bernard. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - outlets
    
    @IBOutlet private var plusButtons: [UIButton]!
    @IBOutlet private var layoutButtons: [UIButton]!
    @IBOutlet private weak var gridView: UIView!
    
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
    
    @IBAction private func layoutButtonTapped(_ sender: UIButton) {
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
    
    @IBAction private func plusButtonTapped(_ sender: UIButton) {
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
                self.gridView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
                
            }, completion: { _ in
                self.share()
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.gridView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
                
            }, completion: { _ in
                self.share()
            })
        }
        
    }
    
    // MARK: - UIActivityViewController
    
    private func share() {
        guard let image = gridView.transformeToImage else { return }
        // UIActivityViewController, trouver comment transformer une vu en image
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewController, animated: true)
        activityViewController.completionWithItemsHandler = { _, _, _, _ in
            UIView.animate(withDuration: 0.5) {
                self.gridView.transform = .identity
            }
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



