//
//  SortingView.swift
//  SortingVisualiser
//
//  Created by Ashish Dutt on 13/04/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct SortingView: View {
    // MARK: Properties
    let layoutProperties: LayoutProperties
    let algo: SortAlgo
    let algorithm: Algorithm
    let pickers = ["Chart Visualiser", "Array Visualiser"]
    @State var view = "Chart Visualiser"
    
    // MARK: View
    var body: some View {
        
        ScrollView {
            VStack{
                Text(algo.rawValue)
                    .font(.system(size: layoutProperties.customFontSize.medium,weight: .bold, design: .monospaced))
                    .padding(4)
                Section {
                    Picker("Pick the Sorting Visualiser",selection: $view){
                        ForEach(pickers,id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Pick a Sorting Visualiser")
                        .font(.system(size: layoutProperties.customFontSize.smallMedium))
                        .opacity(0.4)
                }//:SECTION
                .padding(4)
                if view == pickers[0]{
                    ChartSortView(layoutProperties: layoutProperties, algo: algo)
                }else{
                    AnimatedArrayView(layoutProperties: layoutProperties, algo: algo)
                }
                Divider()
                Spacer()
                VStack(spacing: 10) {
                    Text(algorithm.description)
                        .font(.system(size: layoutProperties.customFontSize.smallMedium,weight: .regular,design: .rounded))
                        .padding(4)
                    Text("Time Complexity: \(algorithm.timeComplexity)")
                        .font(.system(size: 15,weight: .regular,design: .monospaced))
                }//:VSTACK
                Divider()
                VStack(alignment: .center,spacing: 10){
                    Label("Here is the Swift Code for **\(algorithm.algo)**", systemImage: "terminal")
                        .font(.system(size: layoutProperties.customFontSize.smallMedium))
                    Text(algorithm.code)
                        .font(.system(size: layoutProperties.customFontSize.smallMedium,weight: .ultraLight,design: .monospaced))
                }
            }//:VSTACK
            .padding()
            .frame(width: layoutProperties.dimensValues.extraLarge)
        }//:SCROLLVIEW
        .padding(.vertical,30)
    }
}

@available(iOS 16.0, *)
struct SortingView_Previews: PreviewProvider {
    static var previews: some View {
        SortingView(layoutProperties: getPreviewLayoutProperties(landscape: false, height: 1366, width: 1024), algo: .BubbleSort, algorithm: algorithm[0])
    }
}
