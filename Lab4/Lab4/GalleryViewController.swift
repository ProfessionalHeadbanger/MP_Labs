//
//  GalleryViewController.swift
//  Lab4
//
//  Created by vsevolod on 20.10.2024.
//  Copyright © 2024 vsevolod. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UIDropInteractionDelegate {
    
    @IBOutlet var dropZones: [UIView]! {
        didSet {
            for dropZone in dropZones {
                dropZone.addInteraction(UIDropInteraction(delegate: self))
            }
        }
    }
    
    @IBOutlet var galleryViews: [GalleryView]!
    
    @IBOutlet var labels: [UILabel]!
    
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
                for index in self.dropZones.indices {
                    if interaction.view == self.dropZones[index] {
                        self.galleryViews[index].backgroundImage = image
                    }
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
                    for index in self.dropZones.indices {
                        if interaction.view == self.dropZones[index] {
                            self.labels[index].isHidden = false
                            self.labels[index].text = description
                        }
                    }
                }
            }
        }
    }
}
