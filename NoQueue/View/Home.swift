//
//  Home.swift
//  NoQueue
//
//  Created by Nishant Minerva on 31/03/23.
//

import SwiftUI

struct Home: View {
    var body: some View {
//        View Properties
        @State private var activeIntro: PageIntro = pageIntros[0]
        var body: some View {
            GeometryReader{
                let size = $0.size
                
                IntroView(intro: $activeIntro, size: size)
            }
            .padding(15)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//Intro View
struct IntroView: View {
    @Binding var intro: PageIntro
    var size: CGSize
    
    var body: some View {
        VStack {
//             Image View
            GeometryReader {
                let size = $0.size
                
                Image(intro.introAssetImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width, height: size.height)
            }
            
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
                
                if !intro.displayAction {
                    Group{
                        Spacer(minLength: 25)
//                        Custom Indicator View
                        CustomIndicatorView(totalPage: filteredPages.count, currentPage: filteredPages.firstIndex(of: intro) ?? 0)
                            .frame(maxWidth: .infinity)
                        
                        Spacer(minLength: 10)
                        Button {
                            
                        } label: {
                            Text("Next")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: size.width = 0.4)
                                .padding(.vertical, 15)
                                .background {
                                    Capsule()
                                        .fill(.black)
                                }
                                .frame(maxWidth : .infinity)
                        }
                    }
                } else {
                    
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
//    Updating Page Intros's
    var filteredPages: [PageIntro] {
        return pageIntros.filter { !$0.displaysAction }
    }
}
