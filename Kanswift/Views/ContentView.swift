//
//  ContentView.swift
//  Kanswift
//
//  Created by Kadin Sayani on 2023-09-11.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    // sorted by newest on top
    @Query(sort: \Board.timestamp, order: .reverse, animation: .smooth) private var boards: [Board]

    @State private var isAddingBoard = false
    @State private var selectedBoard: Board?

    var body: some View {
        NavigationSplitView {
            List(selection: $selectedBoard) {
                ForEach(boards) { board in
                    NavigationLink {
                        BoardView(board: board, cards: board.cards)
                    } label: {
                        // state counts
                        BoardStatesView(board: board)
                    }
                }
            }
            .navigationSplitViewColumnWidth(min: 260, ideal: 260)
            .toolbar {
                ToolbarItemGroup {
                    Button(action: addBoard) {
                        Label("Add Board", systemImage: "plus")
                    }.keyboardShortcut("b")
                    Button(role: .destructive, action: deleteBoard) {
                        Label("Delete Board", systemImage: "trash")
                    }.keyboardShortcut(.delete)
                }
            }
            .contextMenu {
                Button(action: renameBoard) {
                    Label("Rename", systemImage: "return")
                }
                Button(role: .destructive, action: deleteBoard) {
                    Label("Delete", systemImage: "trash.circle")
                }
            }
        } detail: {
            if let selectedBoard = selectedBoard {
                BoardView(board: selectedBoard, cards: selectedBoard.cards)
            } else {
                Text("Select a Board")
            }
        }.onAppear {
            getNewestBoard()
        }
        .sheet(isPresented: $isAddingBoard) {
            BoardEditorView(isPresented: $isAddingBoard)
        }.keyboardShortcut(/*@START_MENU_TOKEN@*/ .defaultAction/*@END_MENU_TOKEN@*/)
    }

    private func addBoard() {
        isAddingBoard = true
    }

    private func deleteBoard() {
        // TODO: fix bug after all deleted (should show detail)
        // TODO: fix delete board bug
        withAnimation {
            if let selectedBoard = selectedBoard {
                modelContext.delete(selectedBoard)
            }
            do {
                try modelContext.save()
            } catch {
                print(error.localizedDescription)
            }
            getNewestBoard()
        }
    }

    private func getNewestBoard() {
        if let mostRecentBoard = boards.first {
            selectedBoard = mostRecentBoard
        }
    }

    private func renameBoard() {
        // TODO: renameBoard implementatin
        print("renaming board")
    }
}

// #Preview {
//    ContentView()
// }
