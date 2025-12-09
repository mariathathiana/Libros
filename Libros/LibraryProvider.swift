//
//  LibraryProvider.swift
//  Libros
//
//  Created by Mananas on 9/12/25.
//
import Foundation

class LibraryProvider {
    
    static let BASE_URL = "https://openlibrary.org"
    
    static func findBookByCategory(subject: String) async -> [Book] {
        
        guard let url = URL(string: "\(BASE_URL)/subjects/\(subject).json?details=true") else {
            return []
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(BooksResponse.self, from: data)

            // 👉 Aquí puedes imprimir las portadas
            for book in response.works {
                print("Título:", book.title ?? "Sin título")

                if let coverId = book.cover_id {
                    let url = "https://covers.openlibrary.org/b/id/\(coverId)-M.jpg"
                    print("Portada:", url)
                }

                print("---")
            }

            return response.works

        } catch {
            debugPrint("Error decodificando:", error)
            return []
        }
    }
}


