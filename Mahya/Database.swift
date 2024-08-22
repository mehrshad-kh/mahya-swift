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
    
    private let dbQueue: DatabaseQueue
    
    private init() {
        dbQueue = try! DatabaseQueue(path: path)
            
        try! dbQueue.write { db in
            try! db.execute(sql: "SELECT id FROM quotes LIMIT 5;")
        }
    }
    
    static let shared = Database()
    
    var firstQuoteNumber: Int {
        get {
            let query = """
                SELECT week_number
                FROM quotes
                ORDER BY week_number ASC
                LIMIT 1;
                """
            let n = try! dbQueue.read { db in
                try! Int.fetchOne(db, sql: query)
            }
            return n ?? 0
        }
    }
    
    var lastQuoteNumber: Int {
        get {
            let query = """
                SELECT week_number
                FROM quotes
                ORDER BY week_number DESC
                LIMIT 1;
                """
            let n = try! dbQueue.read { db in
                try! Int.fetchOne(db, sql: query)
            }
            return n ?? 0
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
