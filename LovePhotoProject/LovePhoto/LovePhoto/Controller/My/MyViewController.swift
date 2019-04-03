//
//  MyViewController.swift
//  LovePhoto
//
//  Created by 黎应明 on 2019/4/2.
//  Copyright © 2019年 黎应明. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    @IBOutlet weak var TestImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TestImage.whenTapped {
           Tool.loginWith(animated: true, viewController: nil)
        }
        
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
