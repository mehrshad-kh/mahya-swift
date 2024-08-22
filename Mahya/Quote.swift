//
//  Quote.swift
//  Mahya
//
//  Created by Mehrshad on 8/19/24.
//

import Foundation

class Quote {
    var weekNumber = 0
    var text = ""
    var author = ""
    var authorDescription = ""
    var textDescription = ""
    var dateIntended = Date.now
    
    func reset() {
        weekNumber = 0
        text = ""
        author = ""
        authorDescription = ""
        textDescription = ""
        dateIntended = Date.now
    }
}
