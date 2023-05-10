//
//  SortingView.swift
//  SSC
//
//  Created by Ashish Dutt on 12/04/23.
//

import SwiftUI
import Charts
@available(iOS 16.0, *)
struct ChartSortView: View {
    // MARK: Properties
    let layoutProperties: LayoutProperties
    @StateObject var model = SortingAlgos()
    @State private var isSorting: Bool = false
    let algo: SortAlgo
    // MARK: View
    var body: some View {
        VStack(alignment: .center){
            Chart{
                ForEach(Array(zip(model.data.indices,model.data)),id: \.0){index, item in
                    BarMark(x: .value("Position", item), y: .value("Value", index))
                        .foregroundStyle(model.getColor(value: item).gradient)
                }//:Loop
            }//:CHART
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .frame(width: 350,height: 300)
            .padding()
            HStack{
                Button {
                    Task {
                        isSorting = true
                        try await sort()
                        model.activeValue = 0
                        model.previousValue = 0
                        
                        for index in 0..<model.data.count{
                            beep(model.data[index])
                            model.checkValue = model.data[index]
                            try await Task.sleep(until: .now.advanced(by: .milliseconds(20)), clock: .continuous)
                        }
                        isSorting = false
                    }
                } label: {
                    HStack{
                        Label("Sort!", systemImage: "arrow.right.arrow.left")
                            .font(.system(size: layoutProperties.customFontSize.smallMedium,design: .monospaced))
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }//:Button
                Button {
                    withAnimation(.easeInOut(duration: 0.3)){
                        if !isSorting{
                            model.checkValue = nil
                            model.data.shuffle()
                            model.activeValue = 0
                            model.previousValue = 0
                        }
                    }
                } label: {
                    HStack{
                        Label("Shuffle", systemImage: "shuffle")
                            .font(.system(size: layoutProperties.customFontSize.smallMedium,design: .monospaced))
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }//:Button
            }//:HSTACK
            .padding()
            HStack {
                Image(systemName: "hare.fill")
                Slider(value: $model.sortSpeed, in: 10...100)
                Image(systemName: "tortoise.fill")
            }
        }//:VSTACK
        .frame(width: layoutProperties.dimensValues.large,height: 500)
        .onAppear{
            model.data = model.inputs
        }
    }
    // MARK: Functions
    @MainActor
    func sort() async throws{
        switch algo {
        case .BubbleSort:
            try await model.bubbleSort()
        case .InsertionSort:
            try await model.insertionSort()
        case .SelectionSort:
            try await model.selectionSort()
        case .QuickSort:
            try await model.quicksort()
        }
    }
}

@available(iOS 16.0, *)
struct ChartSortView_Previews: PreviewProvider {
    static var previews: some View {
        ChartSortView(layoutProperties: getPreviewLayoutProperties(landscape: false, height: 1366, width: 1024), algo: .QuickSort)
    }
}
