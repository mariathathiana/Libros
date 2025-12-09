//
//  ViewController.swift
//  Libros
//
//  Created by Mananas on 3/12/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Book Cell", for: indexPath) as! BookViewCell
        let works = works[indexPath.row]
        cell.render(with: works)
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text ?? ""
        findBookByCategory(query: searchBar.text ?? "")
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! DetailViewController
        let indexPath = tableView.indexPathForSelectedRow!
        let book = works[indexPath.row]
        detailViewController.works = book
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
