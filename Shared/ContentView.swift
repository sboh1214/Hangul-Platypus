//
//  ContentView.swift
//  Shared
//
//  Created by Seungbin Oh on 2021/01/19.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: Like_HangulDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(Like_HangulDocument()))
    }
}
