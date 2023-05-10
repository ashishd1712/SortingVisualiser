//
//  ThreeDButton.swift
//  SSC
//
//  Created by Ashish Dutt on 30/03/23.
//

import SwiftUI

struct ThreeButton: View{
    let layoutProperties: LayoutProperties
    @State var isPressed: Bool = false
    @EnvironmentObject var nextView: ViewChanger
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 5)
                .frame(width: layoutProperties.dimensValues.medium - 5,height: layoutProperties.dimensValues.smallMedium)
                .offset(y:10)
            RoundedRectangle(cornerRadius: 10)
                .frame(width: layoutProperties.dimensValues.medium - 5,height: layoutProperties.dimensValues.smallMedium)
                .foregroundColor(.gray)
                .offset(y:10)
            Group{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: layoutProperties.dimensValues.medium,height: layoutProperties.dimensValues.smallMedium)
                    .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                    .shadow(radius: 10,y:10)
                Text("Start!")
                    .font(.system(size: layoutProperties.customFontSize.semiMedium,weight: .semibold, design:.monospaced))
                    .foregroundColor(.white)
            }
            .offset(y: isPressed ? 10 : 0)
            .pressEvents(onPress: {
                withAnimation(.easeIn(duration: 0.1)){
                    isPressed = true
                }
            }, onRelease: {
                withAnimation{
                    isPressed = false
                    nextView.next = true
                }
                
            })
        }
    }
}


struct ThreeDButton_Previews: PreviewProvider {
    static var previews: some View {
        ThreeButton(layoutProperties: getPreviewLayoutProperties(landscape: false, height: 1366, width: 1024))
    }
}
