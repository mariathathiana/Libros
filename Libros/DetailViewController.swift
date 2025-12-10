//
//  ViewController.swift
//  Libros
//
//  Created by Mananas on 3/12/25.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var authorLabel: UITextField!
    @IBOutlet weak var isbnLabel: UITextField!
    @IBOutlet weak var subjectLabel: UITextField!
    @IBOutlet weak var coverImageView: UIImageView!
    
    var works: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.text = works.title
            subjectLabel.text = works.subject?.first ?? "Sin categoría"
            
            if let coverId = works.cover_id {
                let urlString = "https://covers.openlibrary.org/b/id/\(coverId)-M.jpg"
                if let url = URL(string: urlString),
                   let data = try? Data(contentsOf: url) {
                    coverImageView.image = UIImage(data: data)
                }
            } else {
                coverImageView.image = UIImage(systemName: "photo")
            }

        
        
    }
    


}

