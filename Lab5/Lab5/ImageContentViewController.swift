//
//  ImageContentViewController.swift
//  Lab5
//
//  Created by vsevolod on 07.11.2024.
//  Copyright © 2024 vsevolod. All rights reserved.
//

import UIKit

class ImageContentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private var imageFetcher: ImageFetcher?
    
    @IBOutlet weak var imageView: UIImageView!
    
    private func fetchImage() {
        guard let url = imageURL else { return }
        
        imageFetcher = ImageFetcher { [weak self] _, image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
        
        imageFetcher?.fetch(url)
    }
    
    var imageURL: URL? {
        didSet {
            fetchImage()
        }
    }
}
