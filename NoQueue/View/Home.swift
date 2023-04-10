//
//  Home.swift
//  NoQueue
//
//  Created by Nishant Minerva on 31/03/23.
//

import SwiftUI

struct Home: View {
    //        View Properties
    @State private var activeIntro: PageIntro = pageIntros[0]
    @State private var emailID: String = ""
    @State private var password: String = ""
    var body: some View {
        GeometryReader{
            let size = $0.size
            
            IntroView(intro: $activeIntro, size: size) {
//                User Login/Signup View
                VStack(spacing: 10) {
//                    Custom TextField
                    CustomTextField(text: $emailID, hint: "Email Address", leadingIcon: Image(systemName: "envelope"))
                    CustomTextField(text: $password, hint: "Password", leadingIcon: Image(systemName: "lock"), isPassword: true)
                    
                    Spacer(minLength: 10)
                    
                    Button {
                        
                    } label: {
                        Text("Continue")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background{
                                Capsule()
                                    .fill(.black)
                            }
                    }
                }
                padding(.top, 25)
            }
        }
        .padding(15)
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Intro View
struct IntroView<ActionView: View>: View {
    @Binding var intro: PageIntro
    var size: CGSize
    var actionView: ActionView
    
    init(intro: Binding<PageIntro>, size: CGSize, @ViewBuilder actionView: @escaping () -> ActionView) {
        self._intro = intro
        self.size = size
        self.actionView = actionView()
    }
    
//    Animation Properties
    @State private var showView: Bool = false
    @State private var hideWholeView: Bool = false
    
    var body: some View {
        VStack {
//             Image View
            GeometryReader {
                let size = $0.size
                
                Image(intro.introAssetImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: size.width, height: size.height)
            }
//            Moving Up
            .offset(y: showView ? 0 : -size.height / 2)
            .opacity(showView ? 1 : 0)
            
//            Title & Action's
            VStack(alignment: .leading, spacing: 10) {
                Spacer(minLength: 0)
                Text(intro.title)
                    .font(.system(size: 40))
                    .fontWeight(.black)
                
                Text(intro.subTitle)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 15)
                
                if !intro.displaysAction {
                    Group{
                        Spacer(minLength: 25)
//                        Custom Indicator View
                        CustomIndicatorView(totalPage: filteredPages.count, currentPage: filteredPages.firstIndex(of: intro) ?? 0)
                            .frame(maxWidth: .infinity)
                        
                        Spacer(minLength: 10)
                        Button {
                            changeIntro()
                        } label: {
                            Text("Next")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: size.width * 0.4)
                                .padding(.vertical, 15)
                                .background {
                                    Capsule()
                                        .fill(.black)
                                }
                                .frame(maxWidth : .infinity)
                        }
                    }
                } else {
//                    Action View
                    
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
//            Moving Down
            .offset(y: showView ? 0 : -size.height / 2)
            .opacity(showView ? 1 : 0)
        }
//        BackButton
        .overlay(alignment: .topLeading) {
//            Hiding it for very First Page, Since there is no previos page present
            if intro != pageIntros.first {
                Button {
                    changeIntro(true)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .contentShape(Rectangle())
                }
                .padding(10)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0).delay(0.1)) {
                showView = true
            }
        }
    }
//    Updating Page Intros's
    func changeIntro(_ isPrevious: Bool = false) {
//        if let index = pageIntros.firstIndex(of: intro), index != pageIntros.count - 1 {
        if let index = pageIntros.firstIndex(of: intro), (isPrevious ? index != 0 : index != pageIntros.count - 1) {
//            intro = pageIntros[index + 1]
            intro = isPrevious ? pageIntros[index - 1] : pageIntros[index + 1]
        } else {
//            intro = pageIntros[pageIntros.count - 1]
            intro = isPrevious ? pageIntros[0] : pageIntros[pageIntros.count  - 1]
        }
    }
    var filteredPages: [PageIntro] {
        return pageIntros.filter { !$0.displaysAction }
    }
}
