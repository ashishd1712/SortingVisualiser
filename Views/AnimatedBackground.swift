//
//  AnimatedBackground.swift
//  SSC
//
//  Created by Ashish Dutt on 30/03/23.
//

import SwiftUI

struct AnimatedBackground: View {
    // MARK: Properties
    @Environment(\.colorScheme) var scheme
    
    let blur: CGFloat = 20
    let backgroundGradient: [Color] = [Color(red: 0.86, green: 0.04, blue: 0.37), Color(red: 0.44, green: 0.00, blue: 0.93)]
    
    // MARK: View
    var body: some View {
        GeometryReader {proxy in
            ZStack{
                Theme.generalBackground
                ZStack{
                    Bubble(
                        proxy: proxy,
                        alignment: .bottomTrailing,
                        color: Theme.ellipsesBottomTrailing(forScheme: scheme),
                        rotationStart: 0,
                        duration: 30
                    )
                    Bubble(
                        proxy: proxy,
                        alignment: .topTrailing,
                        color: Theme.ellipsesTopTrailing(forScheme: scheme),
                        rotationStart: 240,
                        duration: 35
                    )
                    Bubble(
                        proxy: proxy,
                        alignment: .bottomLeading,
                        color: Theme.ellipsesBottomLeading(forScheme: scheme),
                        rotationStart: 120,
                        duration: 40
                    )
                    Bubble(
                        proxy: proxy,
                        alignment: .topLeading,
                        color: Theme.ellipsesTopLeading(forScheme: scheme),
                        rotationStart: 180,
                        duration: 45
                    )
                }
                .blur(radius: blur)
            }
            .ignoresSafeArea(.all)
        }
    }
}


// MARK: Bubble
struct Bubble: View{
    @StateObject var provider = BubbleProvider()
    @State var move: Bool = false
    let proxy: GeometryProxy
    let alignment: Alignment
    let color:Color
    let rotationStart: Double
    let duration: Double
    var body: some View{
        Circle()
            .fill(color)
            .frame(height: proxy.size.height / provider.frameHeightRatio)
            .offset(provider.offset)
            .rotationEffect(.init(degrees: move ? rotationStart : rotationStart + 360))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .opacity(0.8)
            .onAppear{
                withOptionalAnimation(Animation.linear(duration: duration).repeatForever(autoreverses: false)){
                    move.toggle()
                }
            }
    }
}

// MARK: BubbleProvider
class BubbleProvider: ObservableObject{
    let offset : CGSize
    let frameHeightRatio: CGFloat
    init(){
        frameHeightRatio = CGFloat.random(in: 0.7..<1.4)
        offset = CGSize(
            width: CGFloat.random(in: -220..<200),
            height: CGFloat.random(in: -200..<200)
        )
    }
}

struct AnimatedBackground_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedBackground()
    }
}
