//
//  MainView.swift
//  SortingVisualiser
//
//  Created by Ashish Dutt on 13/04/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct MainView: View {
    @EnvironmentObject var viewChanger: ViewChanger
    let layoutProperties: LayoutProperties
    let algo: SortAlgo
    let algorithm: [Algorithm]
    
    var body: some View {
        if viewChanger.next{
            SortNavigation(layoutProperties: layoutProperties, algo: algo, algorithms: algorithm)
        }else{
            StartView(layoutProperties: layoutProperties)
        }
    }
}
