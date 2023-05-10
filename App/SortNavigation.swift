//
//  SortNavigation.swift
//  SSC
//
//  Created by Ashish Dutt on 12/04/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct SortNavigation: View {
    // MARK: Properties
    let layoutProperties: LayoutProperties
    let algo: SortAlgo
    let algorithms: [Algorithm]
    
    // MARK: View
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing:15){
                    Divider()
                    Text("Want to learn about how data is sorted using **different algorithms**? Click one of the **algorithms** down below to learn about them, what's their **Time Complexity** and you can **Visualise** how these sorting algorithms work using two visualisers.")
                        .padding()
                    Divider()
                    ForEach(Array(zip(SortAlgo.allCases, algorithms)), id: \.0){algo, algorithm in
                        NavigationLink(destination: SortingView(layoutProperties: layoutProperties, algo: algo, algorithm: algorithm)) {
                            HStack {
                                Text(algo.rawValue)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }//:HSTACK
                            .padding()
                            .frame(width: 300, height: 50)
                            .foregroundColor(.white)
                            .background(Color.cyan)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(3)
                        }//:NAVIGATION LINK
                    }//:LOOP
                    Divider()
                    VStack{
                        HStack{
                            Text("Developer")
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Ashish Dutt")
                        }
                        .padding()
                        .frame(width: 300, height: 50)
                        HStack{
                            Text("Github")
                                .foregroundColor(.gray)
                            Spacer()
                            Link("Ashish", destination: URL(string: "https://github.com/ashishd1712")!)
                            Image(systemName: "laptopcomputer")
                        }
                        .padding()
                        .frame(width: 300, height: 50)
                        HStack{
                            Text("LinkedIn")
                                .foregroundColor(.gray)
                            Spacer()
                            Link("Ashish", destination: URL(string: "https://www.linkedin.com/in/ashish-dutt-20871a227")!)
                            Image(systemName: "arrow.up.forward.square.fill")
                        }
                        .padding()
                        .frame(width: 300, height: 50)
                    }//:VSTACK
                }//:VSTACK
            }//:SCROLLVIEW
            .navigationTitle("Sorting Visualiser")
            SortingView(layoutProperties: layoutProperties, algo: algo, algorithm: algorithms[0])
        }//:NAVIGATION VIEW
    }//:VIEW
}

@available(iOS 16.0, *)
struct SortNavigation_Previews: PreviewProvider {
    static var previews: some View {
        SortNavigation(layoutProperties: getPreviewLayoutProperties(landscape: false, height: 1366, width: 1024), algo: .BubbleSort, algorithms: algorithm)
    }
}
