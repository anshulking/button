//
//  ViewController.swift
//  ASImagePickerButton
//
//  Created by MAC238 on 7/13/17.
//  Copyright © 2017 tatvasoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController, pickerButtonDelegate {

    @IBOutlet var imagepickerButton: PickerButton!
    @IBOutlet var mainImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagepickerButton.delegate = self
        imagepickerButton.setupButtonFor(viewController: self, pickerType: .cameraRoll)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pickerButtonDidGetImage(_ image: UIImage) {
        mainImageView.image = image
    }
}

