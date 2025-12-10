//
//  BookViewCell.swift
//  Libros
//
//  Created by Mananas on 9/12/25.
//

import UIKit

class BookViewCell: UITableViewCell {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var bookImageView: UIImageView!
   
    @IBOutlet weak var categoryField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookImageView.layer.cornerRadius = 8
        bookImageView.clipsToBounds = true
        // Initialization code
    }


    func render(with works: Book) {
        titleField.text = works.title ?? "Sin título"
        
        if let subjects = works.subject {
                   categoryField.text = subjects.first ?? "Sin categoría"
               } else {
                   categoryField.text = "Sin categoría"
               }
        
        
        if let coverId = works.cover_id {
            let urlString = "https://covers.openlibrary.org/b/id/\(coverId)-M.jpg"
            loadImage(from: urlString)
        } else {
            bookImageView.image = UIImage(systemName: "photo")
        }
        
   

        
    }
    
    private func loadImage(from urlString: String) {
           guard let url = URL(string: urlString) else { return }

           URLSession.shared.dataTask(with: url) { data, _, _ in
               if let data = data, let img = UIImage(data: data) {
                   DispatchQueue.main.async {
                       self.bookImageView.image = img
                   }
               }
           }.resume()
       }
}
