//
//  CartData.swift
//  Äpic
//
//  Created by dev on 12/06/2018.
//  Copyright © 2018 Dev. All rights reserved.
//

import Foundation
import UIKit

class CartData {
    static var imagesInCart: [UIImage] = []
    static var imageQuantities: [Int] = []
    static var imageIndex: [Int] = []
    
    static var countOfImages: Int = -1
    
    static var totalImageQuantity: Int = 0
    
    static func addToTotalQuantity() {
        totalImageQuantity += 1
    }
    
    static func subtractFromTotalQuantity() {
        totalImageQuantity -= 1
    }
}
