//
//  JSONdecoder.swift
//  SortingVisualiser
//
//  Created by Ashish Dutt on 14/04/23.
//

import Foundation
extension Bundle {
    
    func decode<T: Codable>(_ file: String) -> T{
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("Failed to locate \(file) from bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else{
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
    
}
