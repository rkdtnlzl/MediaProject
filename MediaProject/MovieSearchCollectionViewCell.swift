//
//  MovieSearchCollectionViewCell.swift
//  MediaProject
//
//  Created by 강석호 on 6/11/24.
//

import UIKit

class MovieSearchCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieSearchCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
