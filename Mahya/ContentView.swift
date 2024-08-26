//
//  ContentView.swift
//  Mahya
//
//  Created by Mehrshad on 1/10/1402 AP.
//

import SwiftUI

struct ContentView: View {
    enum FocusableField: Hashable {
        case weekNumber, text, author, authorDescription, textDescription, save
    }
    
    @State private var quote = Quote()
    @FocusState private var focusedField: FocusableField?
    
    private var database = Database.shared
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("Week #:")
                    TextField(
                        "Required",
                        value: $quote.weekNumber,
                        formatter: NumberFormatter()
                    )
                    .focused($focusedField, equals: .weekNumber)
                }
                .padding()
                VStack {
                    HStack {
                        Text("Text:")
                        MultilineField("Required", text: $quote.text)
                            .focused($focusedField, equals: .text)
                    }
                    HStack {
                        Text("Author:")
                        TextField("Required", text: $quote.author)
                            .focused($focusedField, equals: .author)
                    }
                }
                .padding()
                VStack {
                    HStack {
                        Text("Author Description:")
                        MultilineField("Optional", text: $quote.authorDescription)
                            .focused($focusedField, equals: .authorDescription)
                    }
                    HStack {
                        Text("Text Description:")
                        MultilineField("Optional", text: $quote.textDescription)
                            .focused($focusedField, equals: .textDescription)
                    }
                }
                .padding()
                
                DatePicker(
                    "Date Intended:",
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
                        .focused($focusedField, equals: .save)
                }
                .padding()
            }
            .onAppear(perform: focusFirstField)
            .onSubmit(focusNextField)
            .padding()
            
            VStack {
                Text("First Saved Quote: Week \(database.firstQuoteNumber)")
                Text("Last Saved Quote: Week \(database.lastQuoteNumber)")
            }
            .padding()
        }
    }
    
    private func focusFirstField() {
        focusedField = .weekNumber
    }
    
    private func focusNextField() {
        switch focusedField {
        case .weekNumber:
            focusedField = .text
        case .text:
            focusedField = .author
        case .author:
            focusedField = .authorDescription
        case .authorDescription:
            focusedField = .textDescription
        case .textDescription:
            focusedField = .save
        case .save:
            focusedField = .weekNumber
        case .none:
            break
        }
    }
    
    private func save() {
        do {
            try database.save(quote: quote)
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
