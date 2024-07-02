//
//  MovieSearchViewController.swift
//  MediaProject
//
//  Created by 강석호 on 6/11/24.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

final class MovieSearchViewController: BaseViewController {
    
    private let searchBar = UISearchBar()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var movies: [MovieResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: width/3, height: width/3+30)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    private func configureNavigation() {
        navigationItem.title = "영화 검색"
    }
    
    override func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    override func configureView() {
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieSearchCollectionViewCell.self, forCellWithReuseIdentifier: MovieSearchCollectionViewCell.identifier)
        
        searchBar.delegate = self
    }
    
    override func configureLayout() {
        
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
        let url = "\(APIURL.tmdbRootUrl)search/movie?api_key=\(APIKey.mediaKey)"
        let param = ["query": query]
        
        AF.request(url, parameters: param).responseDecodable(of: Movie.self) { response in
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSearchCollectionViewCell.identifier, for: indexPath) as? MovieSearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.item]
        let moreMovieVC = MoreMovieViewController()
        moreMovieVC.movieID = movie.id
        navigationController?.pushViewController(moreMovieVC, animated: true)
    }
}

extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text, !query.isEmpty {
            fetchMovies(query: query)
        }
    }
}
