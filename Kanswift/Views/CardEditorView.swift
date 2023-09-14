//
//  CardEditor.swift
//  Kanswift
//
//  Created by Kadin Sayani on 2023-09-11.
//

import SwiftUI
import SwiftData

struct CardEditorView: View {
    @Environment(\.modelContext) private var modelContext
    
    var board: Board
    @Binding var isPresented: Bool
    @State private var cardDescription = ""
    @State private var cardStates = ["Backlog", "Doing", "Review", "Done"]
    @State private var selectedCardState = "Backlog"
    
    var body: some View {
        VStack {
            TextField("Card Description", text: $cardDescription).padding(10)
            
            Picker("State: ", selection: $selectedCardState) {
                ForEach(cardStates, id: \.self) { state in
                    Text(state)
                }
            }.padding(10)
            
            Button("Save") {
                withAnimation {
                    let newCard = Card(cardDescription: cardDescription, cardState: selectedCardState, timestamp: Date())
                    board.cards.append(newCard)
                    do {
                        try modelContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    isPresented = false
                }
            }
            .padding()
        }
        .frame(width: 300, height: 150)
    }
}

//#Preview() {
//    CardEditorView(isPresented: .constant(true))
//}
