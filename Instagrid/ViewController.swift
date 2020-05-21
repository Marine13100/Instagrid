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
    
    // MARK: - view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        print("plus")
    }
}
