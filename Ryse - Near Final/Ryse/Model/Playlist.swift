//
//  Playlist.swift
//  Ryse
//
//  Created by Harry  on 09/12/2021.
//

import Foundation

struct Playlist : Identifiable, Hashable {
    var id = UUID()
    var audios: [Audio]
    var image: String
    var number: String
    var name: String
    var description: String
    var premium: Bool
    var isPicked: Bool
}
