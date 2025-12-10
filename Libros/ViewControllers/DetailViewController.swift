//
//  ViewController.swift
//  Libros
//
//  Created by Mananas on 3/12/25.
//

import UIKit

struct BookDetail: Codable {
    let identifiers: Identifiers?
}

struct Identifiers: Codable {
    let isbn_10: [String]?
    let isbn_13: [String]?
}

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
        authorLabel.text = works.authors?.first?.name ?? "Sin autor"
  
            
            if let coverId = works.cover_id {
                let urlString = "https://covers.openlibrary.org/b/id/\(coverId)-M.jpg"
                if let url = URL(string: urlString),
                   let data = try? Data(contentsOf: url) {
                    coverImageView.image = UIImage(data: data)
                }
            } else {
                coverImageView.image = UIImage(systemName: "photo")
            }
        
        if let key = works.key {
                    let workID = key.replacingOccurrences(of: "/works/", with: "")
                    let urlString = "https://openlibrary.org/books/\(workID).json"
                    print("URL para ISBN:", urlString)
                    
                    // Aquí podrías hacer la llamada a la API para obtener el ISBN
                    Task {
                        if let isbn = await fetchISBN(for: workID) {
                            DispatchQueue.main.async {
                                self.isbnLabel.text = isbn
                            }
                        }
                    }
                } else {
                    isbnLabel.text = "Sin ISBN"
                }
        

        
       
        }

    func fetchISBN(for workID: String) async -> String? {
        let urlString = "https://openlibrary.org/books/\(workID).json"
        guard let url = URL(string: urlString) else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let bookDetail = try JSONDecoder().decode(BookDetail.self, from: data)
            
            // Intentamos primero isbn_13, si no hay usamos isbn_10
            if let isbn13 = bookDetail.identifiers?.isbn_13?.first {
                return isbn13
            } else if let isbn10 = bookDetail.identifiers?.isbn_10?.first {
                return isbn10
            } else {
                return nil
            }
        } catch {
            print("Error al obtener ISBN:", error)
            return nil
        }
    }

        
    }
    




