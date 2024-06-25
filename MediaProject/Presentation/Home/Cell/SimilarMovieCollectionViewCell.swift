//
//  SimilarMovieCell.swift
//  MediaProject
//
//  Created by 강석호 on 6/24/24.
//

import UIKit

class SimilarMovieCollectionViewCell: UICollectionViewCell {
    static let identifier = "SimilarMovieCell"
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
