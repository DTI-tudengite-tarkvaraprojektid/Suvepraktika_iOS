//
//  TermsPopupViewController.swift
//  information1
//
//  Created by dev on 12/06/2018.
//  Copyright © 2018 dev. All rights reserved.
//

import UIKit

class TermsPopupViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backFromTerms(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
}
