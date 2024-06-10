//
//  MediaTableViewCell.swift
//  MediaProject
//
//  Created by 강석호 on 6/10/24.
//

import UIKit
import SnapKit
import SDWebImage

class MediaTableViewCell: UITableViewCell {
    
    static let identifier = "MediaTableViewCell"
    
    let releaseDateLabel = UILabel()
    let mediaTypeLabel = UILabel()
    let containerView = UIView()
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let overviewLabel = UILabel()
    let lineView = UIView()
    let detailLabel = UILabel()
    let detailButton = UIButton()
    let ratingView = UIView()
    let ratingLabel = UILabel()
    let ratingValueLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: Movie) {
        
        releaseDateLabel.text = movie.release_date
        mediaTypeLabel.text = "#\(movie.media_type)"
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        ratingValueLabel.text = String(format: "%.1f", movie.vote_average)
        
        if let posterPath = movie.poster_path {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            posterImageView.sd_setImage(with: posterURL, completed: nil)
        }
    }
    
    func configureUI() {
        
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(mediaTypeLabel)
        contentView.addSubview(containerView)
        
        containerView.addSubview(posterImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(overviewLabel)
        
        contentView.addSubview(lineView)
        contentView.addSubview(detailLabel)
        containerView.addSubview(detailButton)
        containerView.addSubview(ratingView)
        ratingView.addSubview(ratingLabel)
        ratingView.addSubview(ratingValueLabel)
        
        releaseDateLabel.font = UIFont.systemFont(ofSize: 13)
        mediaTypeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
        posterImageView.contentMode = .scaleAspectFill
        
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.backgroundColor = .white
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        overviewLabel.font = UIFont.systemFont(ofSize: 17)
        overviewLabel.numberOfLines = 1
        
        lineView.backgroundColor = .black
        
        detailLabel.font = UIFont.systemFont(ofSize: 15)
        detailLabel.text = "자세히 보기"
        
        detailButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        detailButton.tintColor = .black
        
        ratingView.layer.cornerRadius = 5
        ratingView.backgroundColor = .purple
        
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 15)
        ratingLabel.text = "평점:"
        ratingLabel.textColor = .white
        
        ratingValueLabel.font = UIFont.boldSystemFont(ofSize: 15)
        ratingValueLabel.textColor = .white
    }
    
    func configureLayout() {
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(15)
        }
        
        mediaTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(12)
            make.leading.equalTo(releaseDateLabel)
            make.height.equalTo(15)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(mediaTypeLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(40)
            make.height.equalTo(320)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(containerView.snp.height).multipliedBy(0.6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(1)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).inset(20)
            make.bottom.equalTo(containerView.snp.bottom).inset(15)
        }
        
        detailButton.snp.makeConstraints { make in
            make.trailing.equalTo(containerView.snp.trailing).inset(20)
            make.bottom.equalTo(containerView.snp.bottom).inset(15)
        }
        
        ratingView.snp.makeConstraints { make in
            make.bottom.equalTo(posterImageView.snp.bottom).inset(10)
            make.leading.equalTo(posterImageView.snp.leading).inset(10)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        
        ratingValueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
}
