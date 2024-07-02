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

final class MoreMovieViewController: BaseViewController {
    
    var movieID: Int?
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 200
        view.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.id)
        return view
    }()
    
    private var imageList: [[MovieResponse]] = [
        [MovieResponse(id: 1, poster_path: "")],
        [MovieResponse(id: 1, poster_path: "")],
        [MovieResponse(id: 1, poster_path: "")]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        
        fetchData()
    }
    
    private func fetchData() {
        guard let movieID = movieID else { return }
        
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global().async(group: group) {
            TMDBAPI.shared.fetchSimilarMovies(movieID: movieID) { data in
                DispatchQueue.main.async {
                    self.imageList[0] = data
                    group.leave()
                }
            }
        }
        group.enter()
        DispatchQueue.global().async(group: group) {
            TMDBAPI.shared.fetchRecommendedMovies(movieID: movieID) { data in
                DispatchQueue.main.async {
                    self.imageList[1] = data
                    group.leave()
                }
            }
        }
        group.enter()
        DispatchQueue.global().async(group: group) {
            TMDBAPI.shared.fetchPosterMovies(movieID: movieID) { data in
                DispatchQueue.main.async {
                    self.imageList[2] = data.map { MovieResponse(id: 0, poster_path: $0.file_path ?? "") }
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MoreMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.id, for: indexPath) as? PosterTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "비슷한 영화"
        case 1:
            cell.titleLabel.text = "추천 영화"
        case 2:
            cell.titleLabel.text = "포스터"
        default:
            break
        }
        
        cell.backgroundColor = .white
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.tag = indexPath.row
        cell.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)
        cell.collectionView.reloadData()
        
        return cell
    }
}

extension MoreMovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as? PosterCollectionViewCell else {
            return UICollectionViewCell()
        }
        let data = imageList[collectionView.tag][indexPath.item]
        let posterPath = data.poster_path ?? ""
        if !posterPath.isEmpty {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            cell.posterImageView.kf.setImage(with: url, completionHandler: { result in
                switch result {
                case .success(_):
                    print("Image set successfully")
                case .failure(let error):
                    print("Error setting image: \(error)")
                }
            })
        } else {
            // 기본 이미지를 설정하거나 빈 상태로 둡니다.
            cell.posterImageView.image = nil
        }
        
        return cell
    }
}
