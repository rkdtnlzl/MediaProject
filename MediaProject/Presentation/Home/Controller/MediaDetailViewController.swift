//
//  MediaDetailViewController.swift
//  MediaProject
//
//  Created by 강석호 on 6/12/24.
//

import UIKit
import SnapKit

final class MediaDetailViewController: BaseViewController {
    
    var media: Media?
    
    private let titleLabel = UILabel()
    private let overviewIntroLabel = UILabel()
    private let overviewLabel = UILabel()
    private let posterImageView = UIImageView()
    private let backDropImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = "출연/제작"
    
        updateUI()
    }
    
    override func configureHierarchy() {
        view.addSubview(overviewLabel)
        view.addSubview(posterImageView)
        view.addSubview(overviewIntroLabel)
        posterImageView.addSubview(titleLabel)
        posterImageView.addSubview(backDropImageView)
    }
    
    override func configureView() {
        view.backgroundColor = .white
        
        titleLabel.font = .systemFont(ofSize: 27, weight: .black)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        overviewIntroLabel.font = .boldSystemFont(ofSize: 18)
        overviewIntroLabel.textColor = .gray
        overviewIntroLabel.text = "OverView"
        
        overviewLabel.font = .systemFont(ofSize: 16)
        overviewLabel.numberOfLines = 0
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        
        backDropImageView.contentMode = .scaleAspectFill
        backDropImageView.clipsToBounds = true
        backDropImageView.backgroundColor = .gray
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(220)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.top).inset(20)
            make.leading.equalTo(posterImageView.snp.leading).inset(20)
        }
        
        backDropImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(posterImageView.snp.leading).inset(20)
            make.bottom.equalTo(posterImageView.snp.bottom).inset(20)
            make.width.equalTo(100)
        }
        
        overviewIntroLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewIntroLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func updateUI() {
        guard let media = media else { return }
        titleLabel.text = media.title
        overviewLabel.text = media.overview
        if let posterPath = media.poster_path {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            posterImageView.sd_setImage(with: posterURL, completed: nil)
        }
        if let backDropPath = media.backdrop_path {
            let backDropURL = URL(string: "https://image.tmdb.org/t/p/w500\(backDropPath)")
            backDropImageView.sd_setImage(with: backDropURL, completed: nil)
        }
    }
}
