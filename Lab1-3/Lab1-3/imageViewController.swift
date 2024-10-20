//
//  imageViewController.swift
//  Lab1-3
//
//  Created by vsevolod on 30.09.2024.
//  Copyright © 2024 vsevolod. All rights reserved.
//

import UIKit

class imageViewController: UIViewController, UIScrollViewDelegate {
    
    var image: String?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let image = image else { return }
        
        if let url = URL(string: image), UIApplication.shared.canOpenURL(url) {
            loadImageFromURL(url)
        } else {
            if let localImage = UIImage(named: image) {
                imageView.image = localImage
            }
        }
    }
    
    func loadImageFromURL(_ url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if url == URL(string: self!.image!) {
                        self?.imageView.image = image
                    }
                }
            }
        }
        task.resume()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
