//
//  reusableButton.swift
//  SSC
//
//  Created by Ashish Dutt on 01/04/23.
//

import SwiftUI

struct customButton: View {
    @State var isPressed: Bool = false
    @State var buttonText: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 5)
                .frame(width: 90,height: 40)
                .offset(y:10)
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 90,height: 40)
                .foregroundColor(.gray)
                .offset(y:10)
            Group{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 95,height: 40)
                    .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                    .shadow(radius: 10,y:10)
                Text(buttonText)
                    .font(.system(size: 20,weight: .semibold, design:.monospaced))
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
                }
                
            })
        }

    }
}

struct reusableButton_Previews: PreviewProvider {
    static var previews: some View {
        customButton(buttonText: "Enter")
    }
}
