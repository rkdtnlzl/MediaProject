//
//  UILabel+.swift
//  MediaProject
//
//  Created by 강석호 on 6/28/24.
//

import UIKit

extension UILabel {
    
    func setTitleLabel(title: String) -> UILabel {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
        view.text = title
        view.textColor = .black
        view.font = .systemFont(ofSize: 15)
        return view
    }
    
    func setDescriptionLabel(title: String) -> UILabel {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
        view.text = title
        view.textColor = .black
        view.font = .systemFont(ofSize: 15)
        return view
    }
}
