//
//  CustomIndicatorView.swift
//  NoQueue
//
//  Created by Nishant Minerva on 31/03/23.
//

import SwiftUI

struct CustomIndicatorView: View {
//    View Properties
    var totalPage: Int
    var currentPage: Int
    var activeTint: Color = .black
    var inActiveTint: Color = .gray.opacity(0.5)
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<totalPage, id: \.self) {
                Circle()
                    .fill(currentPage == $0 ? activeTint: inActiveTint)
                    .frame(width: 4,height: 4)
            }
        }
    }
}

struct CustomIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
