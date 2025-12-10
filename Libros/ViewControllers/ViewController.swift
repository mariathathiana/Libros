//
//  ViewController.swift
//  Libros
//
//  Created by Mananas on 3/12/25.
//


import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        findBookByCategory(query:"")
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false

    }
    var works: [Book] = []

    func findBookByCategory(query: String) {
        Task {
            works = await LibraryProvider.findBookByCategory(subject: query)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return works.count
        

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Mostrando celda:", indexPath.row)

        let cell = tableView.dequeueReusableCell(withIdentifier: "Book Cell", for: indexPath) as! BookViewCell
        let works = works[indexPath.row]
        cell.render(with: works)
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        let query = text.lowercased().replacingOccurrences(of: " ", with: "_")
        
        Task {
            let books = await LibraryProvider.findBookByCategory(subject: query)
            
            print("📚 Libros recibidos:", books.count)
            for book in books {
                print("➡️", book.title ?? "SIN TITULO")
            }
            
            // Actualizamos la tabla con los libros recibidos
            self.works = books
            self.tableView.reloadData()
        }
      
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        
        if segue.identifier == "showDetail" {
              let detailVC = segue.destination as! DetailViewController
              
              // Obtener el índice de la celda seleccionada desde el sender
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
         
            tableView.deselectRow(at: indexPath, animated: true)
              
              // Pasar el libro seleccionado
              detailVC.works = works[indexPath.row]
          }
        
        
        
        
    }

}
