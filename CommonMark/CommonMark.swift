//
//  CommonMark.swift
//  CommonMark
//
//  Created by Denis Tokarev on 04/12/15.
//  Copyright © 2015 Denis Tokarev. All rights reserved.
//

@asmname("cmark_markdown_to_html")
func cmark_markdown_to_html(text: UnsafePointer<Int8>,_ len: Int,_ options: Int32) -> UnsafeMutablePointer<Int8>;

import UIKit
import WebKit

public struct MarkdownOptions: OptionSetType {
    public let rawValue: Int32
    public init(rawValue:Int32){ self.rawValue = rawValue}
    
    /**
     Include a data-sourcepos attribute on all block elements.
     */
    public static let SourcePos = MarkdownOptions(rawValue: 1)
    /**
     Render softbreak elements as hard line breaks.
     */
    public static let HardBreaks = MarkdownOptions(rawValue: 2)
    /**
     Normalize tree by consolidating adjacent text nodes.
     */
    public static let Normalize = MarkdownOptions(rawValue: 4)
    /**
     Convert straight quotes to curly, --- to em dashes, -- to en dashes.
     */
    public static let Smart = MarkdownOptions(rawValue: 8)
    /**
     Validate UTF-8 in the input before parsing, replacing illegal sequences with the replacement character U+FFFD.
     */
    public static let ValidateUTF8 = MarkdownOptions(rawValue: 16)
    /**
     Suppress  raw  HTML  and unsafe links (javascript:, vbscript:, file:, and data:, except for image/png, image/gif, image/jpeg, or
     image/webp mime types). Raw HTML is replaced by a placeholder HTML comment. Unsafe links are replaced by empty strings.
     */
    public static let Safe = MarkdownOptions(rawValue: 32)
}

public extension String {
    func markdown2html(options:MarkdownOptions = []) -> String {
        return String(CString: cmark_markdown_to_html(self, utf8.count, options.rawValue), encoding: NSUTF8StringEncoding)!
    }
}

public extension UIWebView {
    func loadMarkdownString(string:String, options:MarkdownOptions = [], baseURL: NSURL? = nil, styleSheet:String? = nil) {
        let url = baseURL ?? NSBundle.mainBundle().bundleURL
        let style = styleSheet ?? "body { font-family:sans-serif; font-size:10pt; }"
        let htmlString = "<html><head><meta name=\"viewport\" content=\"width=device-width\"><style type=\"text/css\">\(style)</style></head><body class = \"markdown-body\">\(string.markdown2html(options))</body></html>"
        
        self.loadHTMLString(htmlString, baseURL: url)
    }
}

public extension WKWebView {
    func loadMarkdownString(string:String, options:MarkdownOptions = [], baseURL: NSURL? = nil, styleSheet:String? = nil) {
        let url = baseURL ?? NSBundle.mainBundle().bundleURL
        let style = styleSheet ?? "body { font-family:sans-serif; font-size:10pt; }"
        let htmlString = "<html><head><meta name=\"viewport\" content=\"width=device-width\"><style type=\"text/css\">\(style)</style></head><body class = \"markdown-body\">\(string.markdown2html(options))</body></html>"
        
        self.loadHTMLString(htmlString, baseURL: url)
    }
}