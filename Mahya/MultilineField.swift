//
//  MultilineEditor.swift
//  Mahya
//
//  Created by Mehrshad on 8/26/24.
//

import SwiftUI

struct MultilineField: View {
    var titleKey: String
    
    @Binding var text: String
    
    init(_ titleKey: String, text: Binding<String>) {
        self.titleKey = titleKey
        self._text = text
    }
    
    var body: some View {
        if #available(macOS 13.0, *) {
            TextField(titleKey, text: $text, axis: .vertical)
                .lineLimit(1...4)
        } else {
            TextEditor(text: $text)
                .border(.green)
        }
    }
}

struct MultilineEditor_Previews: PreviewProvider {
    @State private var text = ""
    
    static var previews: some View {
        MultilineField("Required", text: .constant("Hello, world!"))
    }
}
