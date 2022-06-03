//
//  LessonPlaylistViewModel.swift
//  Ryse
//
//  Created by Harry  on 10/12/2021.
//

import Foundation
import Firebase

class LessonPlaylistViewModel: ObservableObject {
    @Published public var lessonPlaylists = [LessonPlaylist]()
    
    func loadData(){
        Firestore.firestore().collection("LessonPlaylists").order(by: "number", descending: false).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            }else{
                for document in snapshot!.documents {
                    let image = document.data()["image"] as? String ?? "error"
                    let number = document.data()["number"] as? Int ?? 1
                    let name = document.data()["name"] as? String ?? "eror"
                    let description = document.data()["description"] as? String ?? "error"
                    let lessons = document.data()["lessons"] as? [String : [String : Any]]
                    let premium = document.data()["premium"] as? Bool ?? false
                    
                    var lessonsArray = [Lesson]()
                    if let lessons = lessons{
                        for lesson in lessons{
                            let image = lesson.value["image"] as? String ?? "error"
                            let heading = lesson.value["heading"] as? String ?? "error"
                            let intro = lesson.value["intro"] as? String ?? "error"
                            let details = lesson.value["details"] as? String ?? "error"
                            let number = lesson.value["number"] as? Int ?? 1
                            let stepByStep = lesson.value["stepByStep"] as? [String] ?? ["error"]
                            let usefulTips = lesson.value["usefulTips"] as? [String] ?? ["error"]
                            
                            lessonsArray.append(Lesson(image: image, heading: heading, intro: intro, stepByStep: stepByStep, details: details, usefulTips: usefulTips, number: number))
                        }
                    }
                    self.lessonPlaylists.append(LessonPlaylist(lessons: lessonsArray, image: image, number: number, name: name, description: description, premium: premium))
                }
            }
        }
    }
}


//var name: String
//var image: String
//var heading: String
//var intro: String
//var stepByStep: [String]
//var details: String
//var usefulTips: [String]
//var number: Int
