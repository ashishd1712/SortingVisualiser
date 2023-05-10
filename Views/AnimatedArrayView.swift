//
//  AnimatedArrayView.swift
//  SSC
//
//  Created by Ashish Dutt on 13/04/23.
//

import SwiftUI

struct AnimatedArrayView: View {
    // MARK: Properties
    let layoutProperties: LayoutProperties
    @State var array = VisualisedArray()
    @State var isAnimating: Bool = false
    @State var arrAnimation: VisualisedArray.AnimationView?
    let algo: SortAlgo
    
    // MARK: Body
    
    var body: some View {
        VStack{
            Spacer()
            if let animationView = arrAnimation {
                HStack{
                    Spacer()
                    animationView
                    Spacer()
                }
                .padding()
            }
            Spacer()
                Button{
                    if !isAnimating{
                        isAnimating = true
                        arrAnimation = array.animated()
                        arrAnimation?.begin()
                    }
                }label: {
                    Label("Start and Sort!", systemImage: "arrow.right.arrow.left")
                        .padding()
                        .foregroundColor(.white)
                        .background(
                            Color.blue
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }//:Sort Button
            
        }//:VSTACK
        .padding()
        .frame(width: layoutProperties.dimensValues.large ,height: 500)
        .onAppear{
            let nums = (1...10).shuffled()
            array.append(contentsOf: nums)
            array.sort(algo: algo)
        }
    }//: Body
}

// MARK: Extension
extension VisualisedArray {
    mutating func shuffleArray(){
        guard count > 1 else {
            return
        }
        self.shuffle()
    }
    mutating func sort(algo: SortAlgo){
        switch algo{
        case .BubbleSort:
            bubbleSort()
        case .SelectionSort:
            selectionSort()
        case .InsertionSort:
            insertionSort()
        case .QuickSort:
            quickSort()
        }
        
    }
    mutating func bubbleSort() {
        guard count > 1 else {
            return
        }
        for i in 0..<count {
            for j in 0..<(count - i - 1) {
                if self[j] > self[j + 1] {
                    swapAt(j + 1, j)
                }
            }
        }
    }
        
    mutating func selectionSort() {
        for iterationIndex in 0 ..< self.count - 1 {
            
            var minIndex = iterationIndex
            
            for compareIndex in iterationIndex + 1 ..< self.count {
                if self[compareIndex] < self[minIndex] {
                    minIndex = compareIndex
                }
            }
            
            swapAt(iterationIndex, minIndex)
        }
    }
        
    mutating func insertionSort() {
        for i in 1..<count {
            var j = i
            while j > 0 && self[j] < self[j - 1] {
                swapAt(j - 1, j)
                j -= 1
            }
        }
    }
    
    mutating func quickSort() {
        quickSort(startIndex: 0, endIndex: count - 1)
    }
    
    // Quick sort helper method
    private mutating func quickSort(startIndex: Int, endIndex: Int) {
        if startIndex >= endIndex {
            return
        }
        let placedItemIndex = partition(startIndex: startIndex, endIndex: endIndex)
        quickSort(startIndex: startIndex, endIndex: placedItemIndex - 1)
        quickSort(startIndex: placedItemIndex + 1, endIndex: endIndex)
    }
    
    // Quick sort helper method
    private mutating func partition(startIndex: Int, endIndex: Int) -> Int {
        var q = startIndex
        for index in startIndex..<endIndex {
            if self[index] < self[endIndex] {
                swapAt(q, index)
                q += 1
            }
        }
        if q != endIndex {
            swapAt(q, endIndex)
        }
        
        return q
    }
}

struct AnimatedArrayView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedArrayView(layoutProperties: getPreviewLayoutProperties(landscape: false, height: 1366, width: 1024), algo: .QuickSort)
    }
}
