//
//  ChartBubbleSort.swift
//  SSC
//
//  Created by Ashish Dutt on 12/04/23.
//

import Foundation
import SwiftUI

class SortingAlgos: ObservableObject {
    var inputs: [Int] {
        var array = [Int]()
        for i in 1...40 {
            array.append(i)
        }
        return array.shuffled()
    }
    @Published var data = [Int]()
    @Published var activeValue = 0
    @Published var previousValue = 0
    @Published var checkValue: Int?
    @Published var sortSpeed = 20.0
    
    @MainActor
    public func bubbleSort() async throws{
        guard data.count > 1 else {
            return
        }
        for i in 0..<data.count{
            for j in 0..<data.count-i-1{
                activeValue = data[j+1]
                previousValue = data[j]
                if data[j] > data[j+1]{
                    beep(data[j+1])
                    data.swapAt(j+1, j)
                    if #available(iOS 16.0, *) {
                        try await Task.sleep(until: .now.advanced(by: .milliseconds(sortSpeed)), clock: .continuous)
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
        }
    }//:Bubble sort
    
    @MainActor
    public func selectionSort() async throws{
        guard data.count > 1 else{
            return
        }
        
        for i in 0..<data.count - 1{
            var smallest = i
            for j in i+1..<data.count{
                if data[smallest] > data[j]{
                    activeValue = data[j]
                    beep(data[j])
                    smallest = j
                    if #available(iOS 16.0, *) {
                        try await Task.sleep(until: .now.advanced(by: .milliseconds(sortSpeed)), clock: .continuous)
                    } else {
                        // Fallback on earlier versions
                    }
                    
                }
            }
            
            if smallest != i{
                activeValue = data[i]
                previousValue = data[smallest]
                beep(data[smallest])
                data.swapAt(smallest, i)
                if #available(iOS 16.0, *) {
                    try await Task.sleep(until: .now.advanced(by: .milliseconds(sortSpeed)), clock: .continuous)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }//:Selection Sort
    
    @MainActor
    public func insertionSort() async throws{
        guard data.count > 1 else {
            return
        }
        
        for i in 1..<data.count{
            for j in (1...i).reversed(){
                if data[j] < data[j-1]{
                    activeValue = data[j-1]
                    previousValue = data[j]
                    beep(data[j-1])
                    data.swapAt(j, j-1)
                    if #available(iOS 16.0, *) {
                        try await Task.sleep(until: .now.advanced(by: .milliseconds(sortSpeed)), clock: .continuous)
                    } else {
                        // Fallback on earlier versions
                    }
                }else {
                    break
                }
            }
        }
    }
    
    @MainActor
    public func quickSort(_ array: inout [Int], low: Int, high: Int) async throws {
        if low < high {
            let pivot = try await pivot(&array, low: low, high: high)
            try await quickSort(&array, low: low, high: pivot-1)
            try await quickSort(&array, low: pivot+1, high: high)
        }
    }
    @MainActor
    public func pivot(_ array: inout[Int], low: Int, high: Int) async throws -> Int{
        let pivot = array[high]
        var i = low
        for j in low..<high{
            if array[j] <= pivot{
                activeValue = array[i]
                previousValue = array[j]
                beep(data[i])
                if #available(iOS 16.0, *) {
                    try await Task.sleep(until: .now.advanced(by: .milliseconds(sortSpeed)), clock: .continuous)
                } else {
                    // Fallback on earlier versions
                }
                data.swapAt(i, j)
                array.swapAt(i, j)
                i += 1
            }
            activeValue = 0
            previousValue = 0
        }
        
        activeValue = array[i]
        previousValue = array[high]
        
        beep(data[i])
        
        if #available(iOS 16.0, *) {
            try await Task.sleep(until: .now.advanced(by: .milliseconds(sortSpeed)), clock: .continuous)
        } else {
            // Fallback on earlier versions
        }
        
        data.swapAt(i, high)
        array.swapAt(i, high)
        
        return i
    }
    
    @MainActor
    public func quicksort() async throws{
        try await quickSort(&data, low: 0, high: data.count-1)
    }
    
    public func getColor(value: Int) -> Color {
        if let checkValue, value <= checkValue {
            return .green
        }
        if value == activeValue {
            return .green
        }
        else if value == previousValue {
            return .yellow
        }
        else{
            return .blue
        }
    }//:Get color
}

enum SortAlgo: String, CaseIterable{
    case BubbleSort
    case SelectionSort
    case InsertionSort
    case QuickSort
}
