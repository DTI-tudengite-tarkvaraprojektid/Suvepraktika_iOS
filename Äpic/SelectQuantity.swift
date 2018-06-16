//
//  ViewController2.swift
//  Äpic
//
//  Created by Margus Vaigur on 12.05.18.
//  Copyright © 2018 Dev. All rights reserved.
//

import UIKit

class SelectQuantity: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var View2Image: UIImageView!
    
    @IBOutlet weak var quantity: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var subtractButton: UIButton!
    
    @IBOutlet weak var totalPrice: UILabel!
    
    var pictureQuantity: Int = 1 {
        didSet {
            quantity.text = "\(pictureQuantity)"
        }
    }
    
    var image2: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        View2Image.image = image2
        
        pictureQuantity = 1
        
        CartData.addToTotalQuantity()
        totalPrice.text = String(CartData.totalImageQuantity)
    }
    
    //Cartist tagasi tulles Back nupuga
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if CartData.countOfImages != -1 && CartData.imageQuantities.count - 1 == CartData.countOfImages{
            totalPrice.text = String(CartData.totalImageQuantity)
            if !CartData.imagesInCart.contains(image2) {
                quantity.text = String(0)
                pictureQuantity = 0
            } else {
                quantity.text = String(CartData.imageQuantities[CartData.countOfImages])
                pictureQuantity = CartData.imageQuantities[CartData.countOfImages]
            }
        } else {
            if CartData.totalImageQuantity == 0 {
                pictureQuantity = 0
                quantity.text = String(0)
                totalPrice.text = String(CartData.totalImageQuantity)
            } else {
                pictureQuantity = 1
                quantity.text = String(1)
                totalPrice.text = String(CartData.totalImageQuantity)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        pictureQuantity += 1
        CartData.addToTotalQuantity()
        totalPrice.text = String(CartData.totalImageQuantity)
        if CartData.countOfImages != -1 && CartData.imageQuantities.count - 1 == CartData.countOfImages{
            if !CartData.imagesInCart.contains(image2) && pictureQuantity == 1{
                CartData.countOfImages += 1
                CartData.imageQuantities.append(pictureQuantity)
                CartData.imagesInCart.append(image2!)
                CartData.imageIndex.append(CartData.imagesInCart.index(of: image2)!)
            } else {
                CartData.imageQuantities[CartData.countOfImages] += 1
            }
        }
    }
    
    @IBAction func subtractButtonPressed(_ sender: UIButton) {
        if pictureQuantity > 1 {
            pictureQuantity -= 1
            CartData.subtractFromTotalQuantity()
            totalPrice.text = String(CartData.totalImageQuantity)
            if CartData.countOfImages != -1 && CartData.imageQuantities.count - 1 == CartData.countOfImages{
                CartData.imageQuantities[CartData.countOfImages] -= 1
            }
        }
    }
    
    @IBAction func moveToCart(_ sender: UIBarButtonItem) {
        if CartData.totalImageQuantity != 0 && pictureQuantity != 0 {
            if !CartData.imagesInCart.contains(image2) {
                CartData.imageQuantities.append(pictureQuantity)
                CartData.imagesInCart.append(image2!)
                CartData.imageIndex.append(CartData.imagesInCart.index(of: image2)!)
                if CartData.countOfImages == -1 {
                    CartData.countOfImages += 1
                }
            } else {
                CartData.imageQuantities[CartData.countOfImages] = pictureQuantity
            }
            
            performSegue(withIdentifier: "segue3", sender: UIBarButtonItem.self)
        } else {
            let alertTitle = "Quantity can't be 0!"
            let message = "Quantity has to be atleast 1!"
            
            let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
}
