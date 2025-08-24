//
//  AppButton.swift
//  CRM
//
//  Created by Ilia Loviagin on 8/24/25.
//

import SwiftUI

struct AppButton: View {
    @State var text: String
    @State var maxWidth: CGFloat = 300
    @State var foregroundColor: Color = Color.white
    @State var backgroundColor: Color = Color.blue
    @Binding var disable: Bool
    @State var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundColor(foregroundColor)
                .padding(8)
                .frame(maxWidth: maxWidth)
                .background(backgroundColor)
                .cornerRadius(10)
        }
        .buttonStyle(.plain)
        .disabled(disable)
    }
}
