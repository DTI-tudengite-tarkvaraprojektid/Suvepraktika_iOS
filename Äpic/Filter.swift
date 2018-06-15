//
//  ViewController.swift
//  filterTest
//
//  Created by Margus Vaigur on 16.05.18.
//  Copyright © 2018 Dev. All rights reserved.
//

import UIKit
import CoreImage

class Filter: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var blackWhiteButton: UIButton!
    
    @IBOutlet weak var sepiaButton: UIButton!
    
    @IBOutlet weak var coldButton: UIButton!
    
    @IBOutlet weak var warmButton: UIButton!
    
    var vanillaImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = vanillaImage
        buttonsBackgrounds()
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func vanillaFilter(_ sender: UIBarButtonItem) {
        imageView.image = vanillaImage
    }
    
    func buttonsBackgrounds() {
        if vanillaImage != nil {
            blackWhiteButton.setBackgroundImage(vanillaImage, for: .normal)
            thumbnailFilters(filterName: "CIPhotoEffectNoir", buttonName: blackWhiteButton)
            sepiaButton.setBackgroundImage(vanillaImage, for: .normal)
            thumbnailFilters(filterName: "CISepiaTone", buttonName: sepiaButton)
            coldButton.setBackgroundImage(vanillaImage, for: .normal)
            thumbnailFilters(filterName: "CIPhotoEffectProcess", buttonName: coldButton)
            warmButton.setBackgroundImage(vanillaImage, for: .normal)
            thumbnailFilters(filterName: "CIPhotoEffectInstant", buttonName: warmButton)
        }
    }
    
    func thumbnailFilters(filterName: String, buttonName: UIButton) {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: filterName)
        currentFilter!.setValue(CIImage(image: buttonName.backgroundImage(for: .normal)!), forKey: kCIInputImageKey)
        let output = currentFilter!.outputImage
        let cgimg = context.createCGImage(output!,from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        
        buttonName.setBackgroundImage(processedImage, for: .normal)
    }
    
    @IBAction func blackWhiteFilter(_ sender: UIButton) {
        let filterName = "CIPhotoEffectNoir"
        imageView.image = vanillaImage
        changeFilterForPicture(filterName: filterName)
    }
    
    @IBAction func sepiaFilter(_ sender: UIButton) {
        let filterName = "CISepiaTone"
        imageView.image = vanillaImage
        changeFilterForPicture(filterName: filterName)
    }
    
    @IBAction func coldFilter(_ sender: UIButton) {
        let filterName = "CIPhotoEffectProcess"
        imageView.image = vanillaImage
        changeFilterForPicture(filterName: filterName)
    }
    
    @IBAction func warmFilter(_ sender: UIButton) {
        let filterName = "CIPhotoEffectInstant"
        imageView.image = vanillaImage
        changeFilterForPicture(filterName: filterName)
    }
    
    func changeFilterForPicture(filterName: String) {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: filterName)
        currentFilter!.setValue(CIImage(image: imageView.image!), forKey: kCIInputImageKey)
        let output = currentFilter!.outputImage
        let cgimg = context.createCGImage(output!,from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        imageView.image = processedImage
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondController = segue.destination as! SelectQuantity
        secondController.image2 = imageView.image
    }
    
    @IBAction func nextQuantity(_ sender: UIBarButtonItem) {
        if CartData.countOfImages != -1 {
            CartData.countOfImages += 1
        }
        performSegue(withIdentifier: "segue2", sender: nil)
    }
}

