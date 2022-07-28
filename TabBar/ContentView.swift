//
//  ContentView.swift
//  TabBar
//
//  Created by Joanna Lingenfelter on 7/27/22.
//

import SwiftUI

protocol ItemInfo: Hashable, Identifiable {
    var name: String { get }
}

extension ItemInfo {
    var id: String {
        return name
    }
}

struct CustomTabView<Content: View, TabItem: ItemInfo>: View {
    var tabItems: [TabItem]

    @Binding var selection: String
    @ViewBuilder let content: (TabItem) -> Content

    @State var shadow: String = "star"

    var body: some View {
        TabView(selection: $selection) {
            ForEach(tabItems) { item in
                content(item)
                    .tabItem {
                        let isSelected = item.name == shadow
                        VStack {
                            Text(item.name)
                            Image(systemName: isSelected ? "\(item.name).square" : item.name)
                        }
                    }
                    .transaction { transaction in
                        transaction.disablesAnimations = false
                        transaction.animation = .easeIn
                    }
                    .tag(item.name)
            }
        }
        .onChange(of: selection) { newValue in
            DispatchQueue.main.async {
                withAnimation {
                    shadow = newValue
                }
            }
        }
    }
}

struct ContentView: View {
    let items = TabItem.allCases

    @State var selection: String = "star"

    var body: some View {
        CustomTabView(tabItems: items, selection: $selection) { item in
            item.color
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
