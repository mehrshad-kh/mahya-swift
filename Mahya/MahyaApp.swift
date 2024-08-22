//
//  MahyaApp.swift
//  Mahya
//
//  Created by Mehrshad on 1/10/1402 AP.
//

import SwiftUI

@main
struct MahyaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowResizabilityContentSize()
    }
}

extension Scene {
    func windowResizabilityContentSize() -> some Scene {
        if #available(macOS 13.0, *) {
            return windowResizability(.contentSize)
        } else {
            return self
        }
    }
}
