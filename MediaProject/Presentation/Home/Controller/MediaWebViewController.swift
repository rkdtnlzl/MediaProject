//
//  MediaWebViewController.swift
//  MediaProject
//
//  Created by 강석호 on 7/2/24.
//

import UIKit
import SnapKit
import WebKit

class MediaWebViewController: UIViewController {
    
    var urlString: String?
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadURL()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func loadURL() {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
