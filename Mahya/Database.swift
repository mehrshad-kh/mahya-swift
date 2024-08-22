//
//  Database.swift
//  Mahya
//
//  Created by Mehrshad on 8/19/24.
//

import Foundation
import GRDB

class Database {
    private let path = """
        /Users/mehrshadkh./Downloads/Databases/mahya/database.db
        """
    
    static let shared = Database()
    
    // TODO: Improve.
    // TODO: Consider changing to let.
    private var dbQueue: DatabaseQueue
    
    private init() {
        dbQueue = try! DatabaseQueue(path: path)
            
        try! dbQueue.write { db in
            try! db.execute(sql: "SELECT id FROM quotes LIMIT 5;")
        }
    }
    
    func save(quote: Quote) throws {
        let query = """
            INSERT INTO quotes (
            week_number,
            text,
            author,
            author_description,
            text_description,
            date_intended,
            date_time_submitted)
            VALUES (?, ?, ?, ?, ?,
            ?, ?);
            """
        
        try dbQueue.write { db in
            try db.execute(
                sql: query,
                arguments: [
                    quote.weekNumber,
                    quote.text,
                    quote.author,
                    quote.authorDescription,
                    quote.textDescription,
                    quote.dateIntended.formatted(.iso8601
                        .year()
                        .month()
                        .day()),
                    Date.now.ISO8601Format()
                ]
            )
        }

    }
}
