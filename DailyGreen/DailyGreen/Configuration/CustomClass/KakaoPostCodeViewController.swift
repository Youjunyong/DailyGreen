//
//  KakaoPostCodeViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/26.
//

import UIKit
import WebKit

class KakaoPostCodeViewController: UIViewController {

    var webView: WKWebView?
    let indicator = UIActivityIndicatorView(style: .medium)
    var address = ""
    var delegate : WriteDateLocationViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = .systemGray
        setAttributes()
        setContraints()
    }
    
    let cancelButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("닫기", for: .normal)
        btn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        btn.backgroundColor = .white
        btn.setTitleColor(.dark2, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private func setAttributes() {
        let contentController = WKUserContentController()
        contentController.add(self, name: "callBackHandler")

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController

        webView = WKWebView(frame: .zero, configuration: configuration)
        self.webView?.navigationDelegate = self

        guard let url = URL(string: Constant.KAKAO_POSTCODE_URL),
            let webView = webView
            else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        indicator.startAnimating()
    }

    private func setContraints() {
        guard let webView = webView else { return }
        view.addSubview(webView)
        view.addSubview(cancelButton)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40) ,
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            cancelButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            indicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor),
        ])
    }
    @objc func cancel(_ sender: UIButton){
        
        delegate!.dismiss(animated: true, completion: nil)
    }
}

extension KakaoPostCodeViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let data = message.body as? [String: Any] {
            address = data["roadAddress"] as? String ?? ""
            delegate!.getAddress(self.address)
        }
    }
}

extension KakaoPostCodeViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
}
