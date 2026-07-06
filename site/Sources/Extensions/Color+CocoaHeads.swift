//
//  Color+CocoaHeads.swift
//  IgniteStarter
//
//  Created by Mauricio on 5/2/25.
//

import Ignite

// "Mata" palette. These constants feed the Theme structs;
// page and component styling goes through Sources/DesignSystem.
extension Color {
    /// Accent green for fills and large areas.
    static let mata = Color(hex: "#16A05C")

    /// Darker accent for text on light backgrounds (AA contrast).
    static let mataInk = Color(hex: "#0C6E3F")

    /// Tinted fill for badges and soft buttons.
    static let mataSoft = Color(hex: "#E3F5EC")

    /// Accent green lifted for dark mode.
    static let mataBright = Color(hex: "#2FD27D")

    /// Primary text on light backgrounds.
    static let label = Color(hex: "#1C1C1E")

    /// Secondary text on light backgrounds.
    static let secondaryLabel = Color(hex: "#6E6E73")

    /// Grouped background surface.
    static let groupedSurface = Color(hex: "#F2F2F7")
}
