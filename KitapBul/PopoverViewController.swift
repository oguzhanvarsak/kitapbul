//
//  PopoverViewController.swift
//  KitapBul
//
//  Created by Oğuzhan Varsak on 10.06.2021.
//

import Foundation
import UIKit
import WebKit

class PopoverViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let htmlString = String(format: "https://www.amazon.com/s?k=%@", SwiftExampleViewController.ISBN!)
        let url = URL(string: htmlString)
        webView.load(NSURLRequest(url: url! as URL) as URLRequest)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        webView.stopLoading()
        webView.navigationDelegate = nil
        webView.scrollView.delegate = nil
        webView = nil
    }
}
