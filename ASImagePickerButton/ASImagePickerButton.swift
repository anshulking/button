//
//  ASImagePickerButton.swift
//  ASImagePickerButton
//
//  Created by MAC238 on 7/13/17.
//  Copyright © 2017 tatvasoft. All rights reserved.
//

import UIKit

public enum PickerType{
    case camera
    case cameraRoll
    case both
}

@objc protocol pickerButtonDelegate {
    @objc optional func pickerButtonDidGetImage(_ image: UIImage)
}


public class PickerButton: UIButton{
    
    private var pickerType: PickerType = .both
    fileprivate var pickedImage: UIImage = UIImage()
    public var alertStyle: UIAlertControllerStyle = .actionSheet
    private var viewControllerInstance:UIViewController = UIViewController()
    
    var delegate:pickerButtonDelegate?
    
    public func setupButtonFor(viewController: UIViewController , pickerType: PickerType){
        self.pickerType = pickerType
        self.viewControllerInstance = viewController
        self.addTarget(self, action: #selector(setPickerView), for: .touchUpInside)
    }
    
    
    //This function is used for setup image picker
    @objc private func setPickerView(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum){
            switch self.pickerType {
            case .camera:
                setupPhotoCameraPicker()
                break
            case .cameraRoll:
                setupPhotoGalleryPicker()
                break
            case .both:
                let alert = UIAlertController(title: "Alert", message: "Choose One Media", preferredStyle: alertStyle)
                let action1 = UIAlertAction.init(title: "Camera", style: .default) { (UIAlertAction) in
                    self.setupPhotoCameraPicker()
                }
                let action2 = UIAlertAction.init(title: "Photo Gallery", style: .default, handler: { (UIAlertAction) in
                    self.setupPhotoGalleryPicker()
                })
                let action3 = UIAlertAction.init(title: "cancel", style: .cancel, handler: nil)
                alert.addAction(action1)
                alert.addAction(action2)
                alert.addAction(action3)
                viewControllerInstance.present(alert, animated: true, completion: nil)
                break
            }
        }
    }
    
    private func setupPhotoGalleryPicker(){
        let imageViewPicker = UIImagePickerController()
        imageViewPicker.allowsEditing = false
        imageViewPicker.sourceType = .photoLibrary
        imageViewPicker.delegate = self
        viewControllerInstance.present(imageViewPicker, animated: true, completion: nil)
    }
    private func setupPhotoCameraPicker(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            let imageViewPicker = UIImagePickerController()
            imageViewPicker.allowsEditing = false
            imageViewPicker.sourceType = UIImagePickerControllerSourceType.camera
            imageViewPicker.delegate = self
            imageViewPicker.cameraCaptureMode = .photo
            viewControllerInstance.present(imageViewPicker, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Alert", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            viewControllerInstance.present(alert, animated: true, completion: nil)
        }
    }
}

extension PickerButton: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        pickedImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        delegate?.pickerButtonDidGetImage!(pickedImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
