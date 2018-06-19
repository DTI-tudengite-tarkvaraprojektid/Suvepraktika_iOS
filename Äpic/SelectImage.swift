//
//  ViewController.swift
//  Äpic
//
//  Created by Margus Vaigur on 12.05.18.
//  Copyright © 2018 Dev. All rights reserved.
//

import UIKit

class SelectImage: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var Main_Button: UIButton!
    var selectedImage: UIImage!
    
    private let picker = UIImagePickerController()
    private let cropper = UIImageCropper(cropRatio: 2/3)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondController = segue.destination as! Filter
        secondController.vanillaImage = selectedImage
    }
    
    @IBAction func takePicturePressed(_ sender: Any) {
        cropper.cancelButtonText = "Retake"
        
        self.picker.sourceType = .photoLibrary
        self.present(self.picker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Main_Button.layer.cornerRadius = 10
        
        //setup the cropper
        cropper.picker = picker
        cropper.delegate = self
        //cropper.cropRatio = 2/3 //(can be set during runtime or in init)
        cropper.cropButtonText = "Crop" // this can be localized if needed (as well as the cancelButtonText)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension SelectImage: UIImageCropperProtocol {
    func didCropImage(originalImage: UIImage?, croppedImage: UIImage?) {
        selectedImage = croppedImage
        if selectedImage != nil {
            performSegue(withIdentifier: "segue", sender: nil)
        }
        //performSegue(withIdentifier: "segue", sender: nil)
    }
    
    //optional
    func didCancel() {
        picker.dismiss(animated: true, completion: nil)
        print("did cancel")
    }
}
