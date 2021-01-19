//
//  Like_HangulApp.swift
//  Shared
//
//  Created by Seungbin Oh on 2021/01/19.
//

import SwiftUI

@main
struct Like_HangulApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: Like_HangulDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
