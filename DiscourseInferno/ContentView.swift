//
//  ContentView.swift
//  DiscourseInferno
//
//  Created by Kevin Conner on 2023-04-01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello")
//            WebView(url: URL(string: "https://www.duckduckgo.com")!)
//                .edgesIgnoringSafeArea(.all)
        }
        .frame(minWidth: 320, idealWidth: 320, maxWidth: .greatestFiniteMagnitude, minHeight: 240, idealHeight: 240, maxHeight: .greatestFiniteMagnitude)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
