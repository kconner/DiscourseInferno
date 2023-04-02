//
//  WebView.swift
//  DiscourseInferno
//
//  Created by Kevin Conner on 2023-04-01.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    
    let url: URL

    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        nsView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("WebView didFinish navigation")
            
            // No horizontal scrolling please
            let script = "document.body.style.overflowX = 'hidden';"
            webView.evaluateJavaScript(script) { _, error in
                if let error = error {
                    print("Error evaluating JavaScript: \(error.localizedDescription)")
                }
            }
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("WebView didFail navigation with error: \(error.localizedDescription)")
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("WebView didFailProvisionalNavigation with error: \(error.localizedDescription)")
        }

    }
    
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: URL(string: "https://www.duckduckgo.com")!)
    }
}
