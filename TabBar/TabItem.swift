//
//  TabItem.swift
//  TabBar
//
//  Created by Joanna Lingenfelter on 7/27/22.
//

import SwiftUI

enum TabItem: String, ItemInfo, CaseIterable {
    case star
    case heart
    case circle
    case bolt

    var name: String {
        return rawValue
    }

    var color: Color {
        switch self {
        case .star:
            return .yellow
        case .heart:
            return .pink
        case .circle:
            return .green
        case .bolt:
            return .blue
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
