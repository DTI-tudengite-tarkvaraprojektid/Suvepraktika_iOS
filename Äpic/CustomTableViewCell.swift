//
//  CustomTableViewCell.swift
//  Äpic
//
//  Created by dev on 12/06/2018.
//  Copyright © 2018 Dev. All rights reserved.
//

import UIKit

protocol CellDelegate {
    func didTapDeleteButton(id: Int)
    func didTapAddQuantityButton(id: Int)
    func didTapSubtractQuantityButton(id: Int)
}

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var elementThumbnail: UIImageView!
    
    @IBOutlet weak var elementID: UILabel!
    
    @IBOutlet weak var elementQuantity: UILabel!
    
    var delegate: CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delegate?.didTapDeleteButton(id: Int(elementID.text!)! - 1)
    }
    
    @IBAction func addQuantityButtonTapped(_ sender: UIButton) {
        delegate?.didTapAddQuantityButton(id: Int(elementID.text!)! - 1)
    }
    
    @IBAction func subtractQuantityButtontapped(_ sender: UIButton) {
        delegate?.didTapSubtractQuantityButton(id: Int(elementID.text!)! - 1)
    }
}
