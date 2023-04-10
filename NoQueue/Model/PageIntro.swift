//
//  PageIntro.swift
//  NoQueue
//
//  Created by Nishant Minerva on 31/03/23.
//

import SwiftUI

struct PageIntro: Identifiable, Hashable {
    var id: UUID = .init()
    var introAssetImage: String
    var title: String
    var subTitle: String
    var displaysAction: Bool = false
}

var pageIntros: [PageIntro] = [
    .init(introAssetImage: "one", title: "Connect With\nCreators Easily", subTitle: "Thank you for choosing us, we can save your lovely time"),
    .init(introAssetImage: "two", title: "Get Inspiration\nFrom Creator", subTitle: "Find your favourite creator and get inspired by them"),
    .init(introAssetImage: "three", title: "Let's \nGet Started", subTitle: "To register for an account, kindly enter your details", displaysAction: true)
]
