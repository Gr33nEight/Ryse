//
//  RecentAudios.swift
//  Ryse
//
//  Created by Harry  on 09/12/2021.
//

import Foundation

struct Audio : Identifiable, Hashable {
    var id = UUID()
    var description: String
    var image: String
    var name: String
    var number: Int
    var url: String
    var premium: Bool
}
