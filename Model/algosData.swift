//
//  algosData.swift
//  SortingVisualiser
//
//  Created by Ashish Dutt on 14/04/23.
//

import Foundation
import SwiftUI

struct Algorithm: Codable, Identifiable{
    let id: Int
    let algo: String
    let timeComplexity: String
    let description: String
    let code: String
}

let algorithm: [Algorithm] = Bundle.main.decode("algos.json")

