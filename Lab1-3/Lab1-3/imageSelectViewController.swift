//
//  imageSelectViewController.swift
//  Lab1-3
//
//  Created by vsevolod on 30.09.2024.
//  Copyright © 2024 vsevolod. All rights reserved.
//

import UIKit

class imageSelectViewController: UIViewController {

    let localImages = ["image1.jpg", "image2.jpg"]
    let networkImages = ["https://i.imgur.com/2lFqdJR.png", "https://i.pinimg.com/originals/bb/e7/fb/bbe7fb1626a771ad988e188fd11f3e0c.jpg", "https://img.gazeta.ru/files3/397/14400397/chmonya-pic_32ratio_900x600-900x600-7396.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func selectImage(_ sender: UIButton) {
        var url: String = ""
        switch sender.tag {
        case 0: url = localImages[0]
        case 1: url = localImages[1]
        case 2: url = networkImages[0]
        case 3: url = networkImages[1]
        case 4: url = networkImages[2]
        default: break
        }
        
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "imageViewController") as! imageViewController
        storyboard.image = url
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
}
