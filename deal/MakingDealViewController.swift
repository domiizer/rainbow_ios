//
//  MakingDealViewController.swift
//  deal
//
//  Created by DEV on 12/17/19.
//  Copyright © 2019 DEV. All rights reserved.
//

import UIKit

class MakingDealViewController: UIViewController {

    @IBOutlet weak var NextBUI: UIButton!
    @IBOutlet weak var CancelBUI: UIButton!
    
    @IBOutlet weak var TypeLB: UILabel!
    @IBOutlet weak var Image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BG_pattern_big")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
