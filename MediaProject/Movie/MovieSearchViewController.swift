//
//  MovieSearchViewController.swift
//  MediaProject
//
//  Created by 강석호 on 6/11/24.
//

import UIKit

import SnapKit
import Alamofire

class MovieSearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureHierarchy()
        configureUI()
        configureLayout()
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: width/3, height: width/3+20)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    func configureNavigation() {
        navigationItem.title = "영화 검색"
    }
    
    func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieSearchCollectionViewCell.self, forCellWithReuseIdentifier: MovieSearchCollectionViewCell.identifier)
        
        searchBar.delegate = self
    }
    
    func configureLayout() {
        
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func fetchMovies(query: String) {
        let url = "https://api.themoviedb.org/3/search/movie?api_key=\(APIKey.mediaKey)"
        let param = ["query": query]
        
        AF.request(url, parameters: param).responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let movieResponse):
                self.movies = movieResponse.results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MovieSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSearchCollectionViewCell.identifier, for: indexPath) as! MovieSearchCollectionViewCell
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
}

extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text, !query.isEmpty {
            fetchMovies(query: query)
        }
    }
}
