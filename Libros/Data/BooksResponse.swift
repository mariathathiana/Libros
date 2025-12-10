//
//  BooksResponse.swift
//  Libros
//
//  Created by Mananas on 9/12/25.
//

struct BooksResponse: Codable {
    let works: [Book]
}

struct Book: Codable {
    let title: String?
    let edition_count: Int?
    let cover_id: Int?
    let cover_edition_key: String?
    let subject: [String]?
    let authors: [Author]?
    let key: String?
}

struct Author: Codable {
    let name: String?
    let key: String?
}
