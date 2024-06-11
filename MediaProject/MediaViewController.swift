//
//  ViewController.swift
//  MediaProject
//
//  Created by 강석호 on 6/10/24.
//

import UIKit
import SnapKit
import Alamofire

class MediaViewController: UIViewController {
    
    let tableView = UITableView()
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        configureHierarchy()
        configureUI()
        configureLayout()
        fetchMovies()
    }
    
    func fetchMovies() {
        
        let urlString = "https://api.themoviedb.org/3/trending/movie/week?api_key=\(APIKey.mediaKey)"
        
        AF.request(urlString).responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let movieResponse):
                self.movies = movieResponse.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching movies: \(error)")
            }
        }
    }
    
    func configureNavigationItem() {
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButton
        
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func configureHierarchy() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.identifier)
        
        view.addSubview(tableView)
    }
    
    func configureUI() {
        
        view.backgroundColor = .white
        tableView.backgroundColor = .gray
        tableView.rowHeight = 440
        tableView.separatorStyle = .none
    }
    
    func configureLayout() {
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func rightBarButtonTapped() {
        
    }
    
    @objc func leftBarButtonTapped() {
        
    }
}

extension MediaViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.identifier, for: indexPath) as? MediaTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: movies[indexPath.row])
        return cell
    }
}
