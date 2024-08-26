//
//  ContentView.swift
//  Mahya
//
//  Created by Mehrshad on 1/10/1402 AP.
//

import SwiftUI

struct ContentView: View {
    @State private var quote = Quote()
    
    private var database = Database.shared
    
    var body: some View {
        HStack {
            VStack {
                TextField(
                    text: $quote.weekNumber,
                    prompt: Text("Week #")
                    // formatter: NumberFormatter()
                ) {
                    Text("Hello")
                }
                .padding()
                VStack {
                    TextField("Text", text: $quote.text)
                    TextField("Author", text: $quote.author)
                }
                .padding()
                VStack {
                    TextField("Author Description", text: $quote.authorDescription)
                    TextField("Text Description", text: $quote.textDescription)
                }
                .padding()
                
                DatePicker(
                    "Date Intended",
                    selection: $quote.dateIntended,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                
                HStack {
                    Spacer()
                    Button("Save", action: save)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                }
                .padding()
            }
            .padding()
            
            VStack {
                Text("First Saved Quote: Week \(database.firstQuoteNumber)")
                Text("Last Saved Quote: Week \(database.lastQuoteNumber)")
            }
            .padding()
        }
    }
    
    func save() {
        do {
            // try database.save(quote: quote)
            quote.reset()
        } catch {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
