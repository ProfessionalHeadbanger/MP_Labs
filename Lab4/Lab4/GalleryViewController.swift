//
//  GalleryViewController.swift
//  Lab4
//
//  Created by vsevolod on 20.10.2024.
//  Copyright © 2024 vsevolod. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UIDropInteractionDelegate {

    @IBOutlet weak var dropZone1: UIView! {
        didSet {
            dropZone1.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    
    @IBOutlet weak var dropZone2: UIView! {
        didSet {
            dropZone2.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    var imageFetcher: ImageFetcher!
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        imageFetcher = ImageFetcher() { (url, image) in
            DispatchQueue.main.async {
                if interaction.view == self.dropZone1 {
                    self.galleryView1.backgroundImage = image
                }
                else if interaction.view == self.dropZone2 {
                    self.galleryView2.backgroundImage = image
                }
            }
        }
        session.loadObjects(ofClass: NSURL.self) {nsurls in
            if let url = nsurls.first as? URL {
                self.imageFetcher.fetch(url)
            }
        }
        session.loadObjects(ofClass: UIImage.self) {images in
            if let image = images.first as? UIImage {
                self.imageFetcher.backup = image
            }
        }
        session.loadObjects(ofClass: NSString.self) {strings in
            if let description = strings.first as? String {
                DispatchQueue.main.async {
                    if interaction.view == self.dropZone1 {
                        self.descriptionLabel1.isHidden = false
                        self.descriptionLabel1.text = description
                    }
                    else if interaction.view == self.dropZone2 {
                        self.descriptionLabel2.isHidden = false
                        self.descriptionLabel2.text = description
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var galleryView1: GalleryView!
    
    @IBOutlet weak var galleryView2: GalleryView!
    
    @IBOutlet weak var descriptionLabel1: UILabel!
    
    @IBOutlet weak var descriptionLabel2: UILabel!
}
