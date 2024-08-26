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
                HStack {
                    Text("Week #")
                    TextField(
                        "Required",
                        value: $quote.weekNumber,
                        formatter: NumberFormatter()
                    )
                }
                .padding()
                VStack {
                    HStack {
                        Text("Text")
                        TextField("Required", text: $quote.text)
                    }
                    HStack {
                        Text("Author")
                        TextField("Required", text: $quote.author)
                    }
                }
                .padding()
                VStack {
                    HStack {
                        Text("Author Description")
                        TextField("Optional", text: $quote.authorDescription)
                    }
                    HStack {
                        Text("Text Description")
                        TextField("Optional", text: $quote.textDescription)
                    }
                }
                .padding()
                
                DatePicker(
                    "Date Intended",
                    selection: $quote.dateIntended,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .padding()
                
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
