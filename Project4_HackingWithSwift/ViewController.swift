//
//  ViewController.swift
//  Project4_HackingWithSwift
//
//  Created by Victoria Treue on 19/8/21.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    // MARK: - Properties
    
    var webvView: WKWebView!
    var progressView: UIProgressView!
    var website: String?

    
    // MARK: - Lifecycle Hooks
    
    override func loadView() {
        
        webvView = WKWebView()
        webvView.navigationDelegate = self
        view = webvView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = UIColor(red: 40/255, green: 160/255, blue: 180/255, alpha: 1.0)
        
        createUIToolBar()
        connectToWebsite()
    }
    
    
    // MARK: - UI Tool Bar
    
    func createUIToolBar() {
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webvView, action: #selector(webvView.reload))
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        
        let forwardButton = UIBarButtonItem(title: "Forward", style: .plain, target: self, action: #selector(forwardButtonTapped))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView)
                
        toolbarItems = [backButton, forwardButton, progressButton, spacer, refresh]
        
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.tintColor = UIColor(red: 40/255, green: 160/255, blue: 180/255, alpha: 1.0)
        
        webvView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    
    // MARK: - @objc Methods
    
    @objc func backButtonTapped () {
        if webvView.canGoBack {
            webvView.goBack()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func forwardButtonTapped () {
        if webvView.canGoForward {
            webvView.goForward()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    // MARK: - Website
    
    func connectToWebsite () {
        
        let url = URL(string: "https://" + website!)!
        let urlRequest = URLRequest(url: url)
            
        webvView.load(urlRequest)
        webvView.allowsBackForwardNavigationGestures = true
    }
        
    
    // MARK: - Observer
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webvView.estimatedProgress)
        }
    }

    
    // MARK: - Web View
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.url
        
        if url?.absoluteString.contains("http://") == nil {
            
            let alert = UIAlertController(title: "Oops!", message: "This website is blocked. Try another one.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        
        if let host = url?.host {
            if host.contains(website!) {
                decisionHandler(.allow)
                return
            }
        }
        decisionHandler(.cancel)
    }
}

