//
//  WebKitViewController.swift
//  Atlantis
//
//  Created by Drew Boyette on 4/27/17.
//  Copyright © 2017 Drew Boyette. All rights reserved.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController {

    
    @IBOutlet var webView: UIWebView!
    @IBOutlet var containerView: UIView!
    
    override func loadView() {
        super.loadView()
        
        self.view = self.webView!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url = URL(string:"https://www.google.com/search?gl=us&q=B62184&btnG=#gl=us&q=\(selectedFlight.layovers[0].carrier)")
        var req = URLRequest(url: url!)
        self.webView!.loadRequest(req)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
