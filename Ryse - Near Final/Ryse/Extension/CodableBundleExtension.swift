//
//  CodableBundleExtension.swift
//  Ryse
//
//  Created by Harry on 21.09.2020.
//

import Foundation
import SwiftUI

extension Bundle {
    
    func decode<T: Codable>(_ file: String) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }
        
        return loaded
    }
}

extension Color {
    static let ui = Color.UI()
    
    struct UI {
        let secondColor = Color("secondColor")
        
    }
}
