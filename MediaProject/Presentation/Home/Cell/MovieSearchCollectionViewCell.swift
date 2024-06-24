//
//  MovieSearchCollectionViewCell.swift
//  MediaProject
//
//  Created by 강석호 on 6/11/24.
//

import UIKit
import SnapKit
import Kingfisher

class MovieSearchCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieSearchCollectionViewCell"
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: Movie) {
        if let posterPath = movie.poster_path {
            let urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
            if let url = URL(string: urlString) {
                imageView.kf.setImage(with: url)
            }
        }
    }
}
