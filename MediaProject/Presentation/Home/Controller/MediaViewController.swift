//
//  ViewController.swift
//  MediaProject
//
//  Created by 강석호 on 6/10/24.
//

import UIKit
import SnapKit
import Alamofire

class MediaViewController: BaseViewController {
    
    let tableView = UITableView()
    var movies: [Media] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        fetchMedia()
    }
    
    func fetchMedia() {
        
        let urlString = "\(APIURL.tmdbRootUrl)trending/movie/week?api_key=\(APIKey.mediaKey)"
        
        AF.request(urlString).responseDecodable(of: MediaResponse.self) { response in
            switch response.result {
            case .success(let mediaResponse):
                self.movies = mediaResponse.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureNavigationItem() {
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButton
        
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    override func configureHierarchy() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.identifier)
        
        view.addSubview(tableView)
    }
    
    override func configureView() {
        
        view.backgroundColor = .white
        tableView.backgroundColor = .gray
        tableView.rowHeight = 440
        tableView.separatorStyle = .none
    }
    
    override func configureLayout() {
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func leftBarButtonTapped() {
        
    }
    
    @objc func rightBarButtonTapped() {
        let vc = MovieSearchViewController()
        navigationController?.pushViewController(vc, animated: true)
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
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMedia = movies[indexPath.row]
        let detailVC = MediaDetailViewController()
        detailVC.media = selectedMedia
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
