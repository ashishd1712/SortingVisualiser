//
//  visualisedArray.swift
//  SSC
//
//  Created by Ashish Dutt on 13/04/23.
//

import SwiftUI
import UIKit

struct VisualisedArray: MutableCollection, BidirectionalCollection {
    typealias Index = Int
    typealias Element = Int

    private var storage = [Int]()
    private var actions = [Action]()
    
    var startIndex: Index {
        return 0
    }
    
    var endIndex: Index {
        return storage.count
    }
    
    func index(after i: Int) -> Int {
        return i + 1
    }
    
    func index(before i: Int) -> Int {
        return i - 1
    }
    
    mutating func append(_ newElement: Element) {
        let action = Action.append(element: newElement)
        actions.append(action)
        storage.append(newElement)
    }
    
    mutating func swapAt(_ i: Int, _ j: Int) {
        guard indices.contains(i), indices.contains(j) else {
            fatalError("Index out of bounds.")
        }
        guard i != j else {
            return
        }
        let action = Action.swap(i: i, j: j)
        actions.append(action)
        storage.swapAt(i, j)
    }
    @discardableResult
    mutating func remove(at position: Index) -> Element {
        guard indices.contains(position) else {
            fatalError("Index out of bounds.")
        }
        let action = Action.remove(index: position)
        actions.append(action)
        return storage.remove(at: position)
    }
    
    mutating func removeAll() {
        for i in indices.reversed() {
            let action = Action.remove(index: i)
            actions.append(action)
        }
        storage.removeAll()
    }
    
    mutating func removeFirst() -> Element {
        guard !storage.isEmpty else {
            fatalError("Cannot remove element from an empty collection.")
        }
        let action = Action.remove(index: 0)
        actions.append(action)
        return storage.removeFirst()
    }
    
    mutating func removeFirst(_ k: Int) {
        guard k <= storage.count else {
            fatalError("Cannot remove more elements than the collection contains.")
        }
        for _ in 0..<k {
            let action = Action.remove(index: 0)
            actions.append(action)
        }
        return storage.removeFirst(k)
    }
    
    mutating func removeLast() -> Element {
        guard !storage.isEmpty else {
            fatalError("Cannot remove element from an empty collection.")
        }
        let action = Action.remove(index: storage.count - 1)
        actions.append(action)
        return storage.removeLast()
    }
    
    mutating func removeLast(_ k: Int) {
        guard k <= storage.count else {
            fatalError("Cannot remove more elements than the collection contains.")
        }
        for i in ((storage.count - k)..<storage.count).reversed() {
            let action = Action.remove(index: i)
            actions.append(action)
        }
        return storage.removeLast(k)
    }
    
    mutating func append<S>(contentsOf newElements: S) where S: Sequence, S.Element == Element {
        for newElement in newElements {
            let action = Action.append(element: newElement)
            actions.append(action)
            storage.append(newElement)
        }
    }
    
    mutating func insert(_ newElement: Element, at i: Index) {
        guard indices.contains(i) else {
            fatalError("Index out of bounds.")
        }
        let action = Action.insert(element: newElement, index: i)
        actions.append(action)
        storage.insert(newElement, at: i)
    }
    
    mutating func shuffle(){
        guard storage.count > 1 else{
            return
        }
        storage.shuffle()
    }
    
    subscript(position: Index) -> Int {
        get {
            return storage[position]
        }
        set {
            let action = Action.replace(index: position, element: newValue)
            actions.append(action)
            storage[position] = newValue
        }
    }
    
    fileprivate enum Action {
        case swap(i: Int, j: Int)
        case append(element: Int)
        case remove(index: Int)
        case replace(index: Int, element: Int)
        case insert(element: Int, index: Int)
    }
    func animated() -> AnimationView {
        return AnimationView(actions: actions)
    }
    
    struct AnimationView: View {
        
        private typealias Padding = (vertical: CGFloat, horizontal: CGFloat)
        // Sizing and layout
        private let spacing: CGFloat = 5
        private let padding: Padding = (vertical: 5, horizontal: 5)
        private let boxSize = CGSize(
            width: UIScreen.main.bounds.width/50, 
            height: UIScreen.main.bounds.height/30
        )
        
        // Styling
        private let boxColor = UIColor.systemCyan
        private let textColor = UIColor.white
        private let fontSize: CGFloat = 18
        
        // The duration of a single step of the animation in seconds
        private let step: Double = 0.5
        
        
        
        private let maxCount: Int
        private var actions: [Action]
        var view: UIView
        
        var body: some View {
            _AnimationView(view: view)
                .frame(width: view.frame.size.width, height: view.frame.size.height)
        }
        
        fileprivate init(actions: [Action]) {
            self.actions = actions
            self.view = UIView()
            var maxCount = 0
            for action in actions {
                switch action {
                case .append, .insert:
                    maxCount += 1
                case .remove:
                    maxCount -= 1
                default:
                    break
                }
            }
            self.maxCount = maxCount
            
            // Width of box, spacing between boxes, and padding
            let width = boxSize.width * CGFloat(maxCount) + spacing * (CGFloat(maxCount) - 1) + padding.horizontal * 2
            
            // Height of box and padding
            let height = boxSize.height + padding.vertical * 2
            
            view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        }
        
        private struct _AnimationView: UIViewRepresentable {
            let view: UIView
            
            func makeUIView(context: Context) -> UIView {
                return view
            }
            
            func updateUIView(_ uiView: UIView, context: Context) {
                
            }
        }
        
        
        
        private func delay(_ duration: Double) async {
            try! await Task.sleep(nanoseconds: UInt64(duration * Double(NSEC_PER_SEC)))
        }
        
        @MainActor
        func begin() {
            Task {
                var boxes = [UIView]()
                var boxesFrame = CGRect()
                boxesFrame.size.height = boxSize.height
                var delayDuration = step
                for action in actions {
                    switch action {
                    case let .append(element):
                        delayDuration = appendAnimation(
                            element: element,
                            boxes: &boxes,
                            boxesFrame: &boxesFrame
                        )
                        
                    case let .remove(index):
                        delayDuration = removeAnimation(
                            index: index,
                            boxes: &boxes,
                            boxesFrame: &boxesFrame
                        )
                    case let .swap(i, j):
                        delayDuration = swapAnimation(
                            index1: i,
                            index2: j,
                            boxes: &boxes
                        )
                        
                    case let .insert(element, index):
                        delayDuration = insertAnimation(
                            element: element,
                            index: index,
                            boxes: &boxes,
                            boxesFrame: &boxesFrame
                        )
                        
                    case let .replace(index, element):
                        delayDuration = replaceAnimation(
                            element: element,
                            index: index,
                            boxes: &boxes
                        )
                    }
                    await delay(delayDuration + 0.1)
                }
            }
            
            
        }
        
        private func createBox(text: String) -> UIView {
            // Create box
            let box = UIView()
            
            // Set size of box
            box.frame.size = boxSize
            
            // Style box
            box.backgroundColor = boxColor
            box.layer.cornerRadius = 5
            
            // Create text label
            let label = UILabel()
            label.frame = box.bounds
            
            // Style text label
            label.text = text
            label.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
            label.textColor = textColor
            label.textAlignment = .center
            
            // Add label to box and center text
            box.addSubview(label)
            label.frame.center = box.bounds.center
            
            return box
        }
        
        @MainActor
        private func removeAnimation(index: Int, boxes: inout [UIView], boxesFrame: inout CGRect) -> Double {
            let box = boxes[index]
            boxes.remove(at: index)
            boxesFrame.size.height = boxSize.height
            boxesFrame.size.width -= boxSize.width + spacing
            boxesFrame.center = view.bounds.center

            
            UIView.animate(withDuration: step) { [boxes, boxesFrame] in
                for (i, currentBox) in boxes.enumerated() {
                    let x = (spacing + boxSize.width) * CGFloat(i)
                    currentBox.frame.origin.x = boxesFrame.origin.x + x
                }
                box.frame.origin.y = -boxSize.height
                box.alpha = 0
            } completion: { _ in
                box.removeFromSuperview()
            }
            
            return step

        }
        
        @MainActor
        private func swapAnimation(index1: Int, index2: Int, boxes: inout [UIView]) -> Double {
            let box1 = boxes[index1]
            let box2 = boxes[index2]
            
            let location1 = box1.frame.origin
            let location2 = box2.frame.origin
            
            boxes.swapAt(index1, index2)
            
            UIView.animate(withDuration: step / 2) {
                box1.frame.origin.y -= boxSize.height + 5
                box2.frame.origin.y += boxSize.height + 5
            } completion: { _ in
                UIView.animate(withDuration: step) {
                    box1.frame.origin.x = location2.x
                    box2.frame.origin.x = location1.x
                } completion: { _ in
                    UIView.animate(withDuration: step / 2) {
                        box1.frame.origin.y += boxSize.height + 5
                        box2.frame.origin.y -= boxSize.height + 5
                    }
                }
            }
            
            return step * 2
        }
        
        @MainActor
        private func replaceAnimation(element: Int, index: Int, boxes: inout [UIView]) -> Double {
            let box1 = boxes[index]
            
            // Create and add box2 to view
            let box2 = createBox(text: "\(element)")
            view.addSubview(box2)
            
            // Set position of box
            box2.frame.origin.x = box1.frame.origin.x
            box2.frame.origin.y -= boxSize.height + 5
            
            // Style box
            box2.alpha = 0
            
                        
            UIView.animate(withDuration: step) {
                box1.frame.origin.y += boxSize.height + 5
                box1.alpha = 0
                box2.frame.origin.y += boxSize.height + 5
                box2.alpha = 1
            } completion: { _ in
                box1.removeFromSuperview()
            }
            
            // Replace box with new box
            boxes[index] = box2
            
            return step
        }
        
        
        @MainActor
        private func appendAnimation(element: Int, boxes: inout [UIView], boxesFrame: inout CGRect) -> Double {
            
            boxesFrame.size.height = boxSize.height
            boxesFrame.size.width += boxSize.width + (boxes.isEmpty ? 0 : spacing)
            boxesFrame.center = view.bounds.center

            // Create and add box to view
            let box = createBox(text: "\(element)")
            view.addSubview(box)
            
            // Set position of box
            box.frame.origin.x = boxesFrame.maxX - boxSize.width
            box.frame.origin.y = boxesFrame.origin.y - boxSize.width
            
            // Style box
            box.alpha = 0
          
            // Adjust position of boxes
            UIView.animate(withDuration: step) { [boxes, boxesFrame] in
                for (i, currentBox) in boxes.enumerated() {
                    let x = (spacing + boxSize.width) * CGFloat(i)
                    currentBox.frame.origin.x = boxesFrame.origin.x + x
                }
                box.frame.origin.y = boxesFrame.origin.y
                box.alpha = 1
            }
            
            // Add box to boxes array
            boxes.append(box)
            
            return step
        }
        
        @MainActor
        private func insertAnimation(element: Int, index: Int, boxes: inout [UIView], boxesFrame: inout CGRect) -> Double {
            
            boxesFrame.size.height = boxSize.height
            boxesFrame.size.width += boxSize.width + (boxes.isEmpty ? 0 : spacing)
            boxesFrame.center = view.bounds.center
            
            // Create and add box to view
            let box = createBox(text: "\(element)")
            view.addSubview(box)
            
            // Set position of box
            box.frame.origin.x = boxesFrame.minX + CGFloat(index) * (boxSize.width + spacing)
            box.frame.origin.y = boxesFrame.origin.y - boxSize.width
            
            // Style box
            box.alpha = 0
            
            // Add box to boxes array
            boxes.insert(box, at: index)
            
            // Adjust position of boxes
            UIView.animate(withDuration: step) { [boxes, boxesFrame] in
                for (i, currentBox) in boxes.enumerated() where i != index {
                    let x = (spacing + boxSize.width) * CGFloat(i)
                    currentBox.frame.origin.x = boxesFrame.origin.x + x
                }
                box.frame.origin.y = boxesFrame.origin.y
                box.alpha = 1
            }
            
            
            return step
        }
        
        
    }
}
public extension CGRect {
    
    /// The center point of a `CGRect`.
    var center: CGPoint {
        get {
            return CGPoint(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2))
        }
        set (point) {
            origin.y = point.y - (size.height / 2)
            origin.x = point.x - (size.width / 2)
        }
    }
}


extension VisualisedArray: CustomStringConvertible {
    var description: String {
        return storage.description
    }
}

