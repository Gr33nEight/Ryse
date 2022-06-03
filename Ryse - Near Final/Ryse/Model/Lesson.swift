//
//  Lesson.swift
//  Ryse
//
//  Created by Harry  on 10/12/2021.
//

import Foundation
import SwiftUI

struct Lesson : Identifiable, Hashable {
    var id = UUID()
    var image: String
    var heading: String
    var intro: String
    var stepByStep: [String]
    var details: String
    var usefulTips: [String]
    var number: Int
}
