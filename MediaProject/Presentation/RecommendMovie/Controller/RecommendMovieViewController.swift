//
//  MediaListViewController.swift
//  MediaProject
//
//  Created by 강석호 on 6/24/24.
//

import UIKit
import SnapKit

class RecommendMovieViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        configureHierarchy()
        configureUI()
        configureLayout()
    }
    
    func configureNavigationItem() {
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: .none)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func configureHierarchy() {
        
    }
    
    func configureUI() {
        view.backgroundColor = .white
    }
    
    func configureLayout() {
    }
    

}
