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
            WebView(url: URL(string: "https://chat.openai.com/chat")!)
                .edgesIgnoringSafeArea(.all)
        }
        .frame(minWidth: dockedWidth, idealWidth: dockedWidth, maxWidth: .greatestFiniteMagnitude, minHeight: 240, idealHeight: 240, maxHeight: .greatestFiniteMagnitude)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
