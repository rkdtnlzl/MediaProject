//
//  MoreMovieViewController.swift
//  MediaProject
//
//  Created by 강석호 on 6/24/24.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

class MoreMovieViewController: UIViewController {

    var movieID: Int?
    var similarMovies: [Movie] = []
    var recommendedMovies: [Movie] = []
    let similarMovieLabel = UILabel()
    let recommendedMovieLabel = UILabel()
    lazy var similarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: similarCollectionViewLayout())
    lazy var recommendedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: recommendedCollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        configureHierarchy()
        configureUI()
        configureLayout()
        
        if let movieID = movieID {
            fetchSimilarMovies(movieID: movieID)
            fetchRecommendedMovies(movieID: movieID)
        }
    }
    
    func configureNavigationItem() {
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: .none)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func configureHierarchy() {
        view.addSubview(similarMovieLabel)
        view.addSubview(similarCollectionView)
        view.addSubview(recommendedMovieLabel)
        view.addSubview(recommendedCollectionView)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        similarMovieLabel.text = "비슷한 영화"
        similarMovieLabel.font = .boldSystemFont(ofSize: 17)
        
        recommendedMovieLabel.text = "추천 영화"
        recommendedMovieLabel.font = .boldSystemFont(ofSize: 17)
        
        similarCollectionView.delegate = self
        similarCollectionView.dataSource = self
        similarCollectionView.register(SimilarMovieCell.self, forCellWithReuseIdentifier: SimilarMovieCell.identifier)
        
        recommendedCollectionView.delegate = self
        recommendedCollectionView.dataSource = self
        recommendedCollectionView.register(RecommendedMovieCell.self, forCellWithReuseIdentifier: RecommendedMovieCell.identifier)
    }
    
    func configureLayout() {
        similarMovieLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        similarCollectionView.snp.makeConstraints { make in
            make.top.equalTo(similarMovieLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(160)
        }
        
        recommendedMovieLabel.snp.makeConstraints { make in
            make.top.equalTo(similarCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        recommendedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendedMovieLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(180)
        }
    }
    
    func similarCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: 100, height: 140)
        return layout
    }
    
    func recommendedCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: 120, height: 160)
        return layout
    }
    
    func fetchSimilarMovies(movieID: Int) {
        let url = "\(APIURL.tmdbRootUrl)movie/\(movieID)/similar"
        let params: [String: Any] = ["api_key": APIKey.mediaKey]
        
        AF.request(url, parameters: params).responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let movieResponse):
                self.similarMovies = movieResponse.results
                DispatchQueue.main.async {
                    self.similarCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchRecommendedMovies(movieID: Int) {
        let url = "\(APIURL.tmdbRootUrl)movie/\(movieID)/recommendations"
        let params: [String: Any] = ["api_key": APIKey.mediaKey]
        
        AF.request(url, parameters: params).responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let movieResponse):
                self.recommendedMovies = movieResponse.results
                DispatchQueue.main.async {
                    self.recommendedCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MoreMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == similarCollectionView {
            return similarMovies.count
        } else {
            return recommendedMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == similarCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCell.identifier, for: indexPath) as! SimilarMovieCell
            let movie = similarMovies[indexPath.item]
            cell.configure(with: movie)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedMovieCell.identifier, for: indexPath) as! RecommendedMovieCell
            let movie = recommendedMovies[indexPath.item]
            cell.configure(with: movie)
            return cell
        }
    }
}
