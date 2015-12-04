# cmark-swift-wrapper

This is a simple wrapper around `cmark` that allows to display `CommonMark` inside `UIWebView` and `WKWebView`.

# Example Usage

```
import UIKit
import WebKit
import CommonMark

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)
        
        let baseURL = NSURL(string: "https://raw.githubusercontent.com/sindresorhus/github-markdown-css/gh-pages/")!
        let textURL = baseURL.URLByAppendingPathComponent("readme.md")
        let cssURL = baseURL.URLByAppendingPathComponent("github-markdown.css")
        
        let css = try! String(contentsOfURL:cssURL)
        let text = try! String(contentsOfURL:textURL)
        
        webView.loadMarkdownString(text, baseURL: baseURL, styleSheet:css)
    }
}
```