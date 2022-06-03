//
//  LessonPlaylist.swift
//  Ryse
//
//  Created by Harry  on 10/12/2021.
//

import Foundation

struct LessonPlaylist : Identifiable, Hashable {
    var id = UUID()
    var lessons: [Lesson]
    var image: String
    var number: Int
    var name: String
    var description: String
    var premium: Bool
}

