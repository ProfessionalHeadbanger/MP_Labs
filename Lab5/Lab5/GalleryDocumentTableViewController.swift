//
//  GalleryDocumentTableViewController.swift
//  Lab5
//
//  Created by vsevolod on 06.11.2024.
//  Copyright © 2024 vsevolod. All rights reserved.
//

import UIKit

struct GalleryDocument {
    let name: String
    let url: URL
}

class GalleryDocumentTableViewController: UITableViewController {

    // MARK: = Model
    
    var galleryDocuments = [GalleryDocument]()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if splitViewController?.preferredDisplayMode != .primaryOverlay {
            splitViewController?.preferredDisplayMode = .primaryOverlay
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleryDocuments.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
        cell.textLabel?.text = galleryDocuments[indexPath.row].name
        print("Cell at row \(indexPath.row) with name: \(galleryDocuments[indexPath.row].name)" )
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = galleryDocuments[indexPath.row].url
        print("Selected row at \(indexPath.row)")
        
        if let imageContentVC = (splitViewController?.viewControllers.last as? ImageContentViewController) ?? (splitViewController?.viewControllers.last as? UINavigationController)?.topViewController as? ImageContentViewController {
            imageContentVC.imageURL = selected
        }
    }
    
    @IBAction func addGalleryDocument(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add Image", message: "Enter URL", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Image URL"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let urlString = alertController.textFields?.first?.text, let url = URL(string: urlString), !urlString.isEmpty {
                let imageName = url.lastPathComponent.madeUnique(withRespectTo: self.galleryDocuments.map {$0.name})
                let newDocument = GalleryDocument(name: imageName, url: url)
                self.galleryDocuments.append(newDocument)
                self.tableView.reloadData()
            }
        }
        
        alertController.addAction(addAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func hideTable(_ sender: UIBarButtonItem) {
        if let splitVC = splitViewController {
            if splitVC.preferredDisplayMode == .primaryHidden {
                splitVC.preferredDisplayMode = .automatic
            }
            else {
                splitVC.preferredDisplayMode = .primaryHidden
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            galleryDocuments.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
