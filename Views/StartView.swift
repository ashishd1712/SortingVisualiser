//
//  ContentView.swift
//  SSC
//
//  Created by Ashish Dutt on 27/03/23.
//

import SwiftUI

struct StartView: View {
    // MARK: Properties
    let layoutProperties: LayoutProperties
    let backgroundGradient: [Color] = [Color(red: 0.86, green: 0.04, blue: 0.37), Color(red: 0.44, green: 0.00, blue: 0.93)]
    // MARK: View
    var body: some View {
        
        ZStack{
            //: Background gradient
            
            AnimatedBackground()
            VStack(spacing: 10){
                Text("Sorting Visualiser")
                    .padding()
                    .font(.custom("Impact", size: layoutProperties.customFontSize.extraLarge))
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.2))
                    )
                    .shadow(color: .black, radius: 10, x: 0, y: 10
                    )
                    .padding()
                Spacer()
                ThreeButton(layoutProperties: layoutProperties)
            }//:VStack
            .frame(height: 500)
            
        }//:Zstack
        .ignoresSafeArea(.all)
        
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(layoutProperties: getPreviewLayoutProperties(landscape: false, height: 1366, width: 390))
    }
}

