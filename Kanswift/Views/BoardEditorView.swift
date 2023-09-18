//
//  CardEditor.swift
//  Kanswift
//
//  Created by Kadin Sayani on 2023-09-11.
//

import SwiftUI
import SwiftData

struct BoardEditorView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Binding var isPresented: Bool
    @State private var title = ""
    
    var body: some View {
            VStack {
                Spacer()
                Text("New Board").font(.title)
                Spacer()
                TextField("Board Title", text: $title).padding(10).frame(height:50)
                    .textFieldStyle(PlainTextFieldStyle())
                    .cornerRadius(5).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray)).padding(10)
                Spacer()
                Button("Save") {
                    let newBoard = Board(title: title, timestamp: Date(), cards: [])
                    modelContext.insert(newBoard)
                    isPresented = false
                }
                .padding()
            }
            .frame(width: 300, height: 200)
    }
}

//#Preview() {
//    CardEditorView(isPresented: .constant(true))
//}
