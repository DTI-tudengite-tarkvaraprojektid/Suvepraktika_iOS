//
//  Cart.swift
//  Äpic
//
//  Created by dev on 12/06/2018.
//  Copyright © 2018 Dev. All rights reserved.
//

import UIKit

class Cart: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBOutlet weak var totalPrice: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartData.imagesInCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        cell.elementID.text = String(CartData.imageIndex[indexPath.row] + 1)
        cell.elementThumbnail.image = CartData.imagesInCart[indexPath.row]
        cell.elementQuantity.text = String(CartData.imageQuantities[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    //delete picture from cart
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        
        if tableView.isEditing {
            editButton.title = "Done"
        } else {
            editButton.title = "Edit"
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index : Int = (indexPath.section * CartData.imagesInCart.count) + indexPath.row
            CartData.totalImageQuantity -= CartData.imageQuantities[index]
            totalPrice.text = String(CartData.totalImageQuantity)
            
            CartData.imagesInCart.remove(at: indexPath.row)
            CartData.imageQuantities.remove(at: indexPath.row)
            CartData.imageIndex.remove(at: indexPath.row)
            var x: Int = 0
            while x < CartData.imagesInCart.count {
                CartData.imageIndex[x] = x
                x += 1
            }
            tableView.reloadData()
            CartData.countOfImages -= 1
        }
    }
    
    @IBAction func checkoutButtonTapped(_ sender: UIButton) {
        if CartData.totalImageQuantity >= 5 {
            performSegue(withIdentifier: "testsegue", sender: nil)
        } else {
            let alertTitle = "Alert!"
            let message = "Total price has to be atleast 5€!"
            
            let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    //add picture
    var selectedImage: UIImage!
    
    private let picker = UIImagePickerController()
    private let cropper = UIImageCropper(cropRatio: 2/3)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let secondController = segue.destination as! Filter
            secondController.vanillaImage = selectedImage
        } else if segue.identifier == "testsegue" {
            //let secondController = segue.destination as! UserInputInfo
        }
        
    }
    
    @IBAction func addPicture(_ sender: Any) {
        cropper.cancelButtonText = "Retake"
        
        self.picker.sourceType = .photoLibrary
        self.present(self.picker, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalPrice.text = String(CartData.totalImageQuantity)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //setup the cropper
        cropper.picker = picker
        cropper.delegate = self
        //cropper.cropRatio = 2/3 //(can be set during runtime or in init)
        cropper.cropButtonText = "Crop" // this can be localized if needed (as well as the cancelButtonText)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension Cart: UIImageCropperProtocol {
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

extension Cart: CellDelegate {
    func didTapAddQuantityButton(id: Int) {
        CartData.imageQuantities[id] += 1
        let indexPath = IndexPath(item: id, section: 0)
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        
        CartData.addToTotalQuantity()
        totalPrice.text = String(CartData.totalImageQuantity)
    }
    
    func didTapSubtractQuantityButton(id: Int) {
        if CartData.imageQuantities[id] > 1 {
            CartData.imageQuantities[id] -= 1
            let indexPath = IndexPath(item: id, section: 0)
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
            
            CartData.subtractFromTotalQuantity()
            totalPrice.text = String(CartData.totalImageQuantity)
        }
    }
}
