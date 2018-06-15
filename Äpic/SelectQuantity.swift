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
        print("KOGU KOGUS PEALE VAATE LAADIMIST")
        print(CartData.totalImageQuantity)
    }
    
    //Cartist tagasi tulles Back nupuga
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("COUNTOFIMAGES ON " + String(CartData.countOfImages) + " IMAGEQUANTITIES.COUNT-1 ON " + String(CartData.imageQuantities.count - 1))
        if CartData.countOfImages != -1 && CartData.imageQuantities.count - 1 == CartData.countOfImages{
            print("TRUE")
            totalPrice.text = String(CartData.totalImageQuantity)
            if !CartData.imagesInCart.contains(image2) {
                quantity.text = String(0)
                pictureQuantity = 0
            } else {
                quantity.text = String(CartData.imageQuantities[CartData.countOfImages])
                print("ANTUD LIIKME VÄÄRTUS " + String(CartData.imageQuantities[CartData.countOfImages]))
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
        print("COUNT-1 ON " + String(CartData.imageQuantities.count - 1) + " JA COUNTOFIMAGES ON " + String(CartData.countOfImages))
        print("PICTUREQUANTITY ON " + String(pictureQuantity))
        if CartData.countOfImages != -1 && CartData.imageQuantities.count - 1 == CartData.countOfImages{
            if !CartData.imagesInCart.contains(image2) && pictureQuantity == 1{
                print("TRUE PEAKS OLEMA")
                CartData.countOfImages += 1
                CartData.imageQuantities.append(pictureQuantity)
                CartData.imagesInCart.append(image2!)
                CartData.imageIndex.append(CartData.imagesInCart.index(of: image2)!)
                CartData.imageQuantities[CartData.countOfImages] += 1
            } else {
                CartData.imageQuantities[CartData.countOfImages] += 1
            }
            print("ADD ANTUD LIIKME ID " + String(CartData.countOfImages) + " JA VÄÄRTUS " + String(CartData.imageQuantities[CartData.countOfImages]))
        }
        print("IMAGEQUANTITY.COUNT-1 ON " + String(CartData.imageQuantities.count - 1) + " JA COUNTOFIMAGES " + String(CartData.countOfImages))
    }
    
    @IBAction func subtractButtonPressed(_ sender: UIButton) {
        if pictureQuantity > 1 {
            pictureQuantity -= 1
            CartData.subtractFromTotalQuantity()
            totalPrice.text = String(CartData.totalImageQuantity)
            if CartData.countOfImages != -1 && CartData.imageQuantities.count - 1 == CartData.countOfImages{
                CartData.imageQuantities[CartData.countOfImages] -= 1
                print("SUB ANTUD LIIKME ID " + String(CartData.countOfImages) + " JA VÄÄRTUS " + String(CartData.imageQuantities[CartData.countOfImages]))
            }
            print("IMAGEQUANTITY.COUNT-1 ON " + String(CartData.imageQuantities.count - 1) + " JA COUNTOFIMAGES " + String(CartData.countOfImages))
        }
    }
    
    //PEALE KUSTUTAMIST LÄHEB ID PAIGAST ÄRA JA HAKKAB LISAMA EELMISELE ELEMENDILE!!!!!!!!!!!
    
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
            let message = "Quantity and total price have to be bigger than 0!"
            
            let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
}
