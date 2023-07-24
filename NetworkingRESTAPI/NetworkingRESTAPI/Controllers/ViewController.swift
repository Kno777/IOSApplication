//
//  ViewController.swift
//  NetworkingRESTAPI
//
//  Created by Kno Harutyunyan on 24.07.23.
//

import UIKit

class ViewController: UITableViewController {
    
    let reuseIndentifier = "MovieCellId"
    
    var movies: [Movie]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureTableView()
        
        let movieManager = MovieManager()
        movieManager.fetchData { movie in
            DispatchQueue.main.async {
                self.navigationItem.title = movie.title
                self.navigationController?.navigationBar.barTintColor = .darkGray
            }
            self.movies = movie.movies
        }
    }

    private func configureTableView() {
        tableView.backgroundColor = .darkGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIndentifier)
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIndentifier, for: indexPath)
        
        cell.backgroundColor = .darkGray
        
        guard let movie = self.movies?[indexPath.row] else { return cell }
        
        cell.textLabel?.text = "\(movie.title) - \(movie.releaseYear)"
        
        return cell
    }
}

