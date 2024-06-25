//
//  PosterTableViewCell.swift
//  MediaProject
//
//  Created by 강석호 on 6/25/24.
//

import UIKit
import SnapKit

class PosterTableViewCell: BaseTableViewCell {
    
    static let id = "PosterTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.text = "비슷한 영화"
        label.textColor = .black
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: PosterTableViewCell.layout())
    }()
    
    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    override func configureView() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(20)
        }
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
    }
}
