//
//  ViewController.swift
//  MediaProject
//
//  Created by 강석호 on 6/10/24.
//

import UIKit

class ViewController: UIViewController {

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureNavigationItem()
        configureHierarchy()
        configureUI()
        configureLayout()
    }
    
    func configureNavigationItem() {
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButton
        
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func configureHierarchy() {
        
        view.addSubview(tableView)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        tableView.backgroundColor = .gray
    }
    
    func configureLayout() {
        
        
    }
    
    @objc func rightBarButtonTapped() {
        
    }
    
    @objc func leftBarButtonTapped() {
        
    }


}

