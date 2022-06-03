//
//  RecentAudiosViewModel.swift
//  Ryse
//
//  Created by Harry  on 09/12/2021.
//

import Foundation
import Firebase

class RecentAudiosViewModel: ObservableObject {
    @Published public var audios = [Audio]()
    
    func loadData() {
        Firestore.firestore().collection("RecentAudios").order(by: "number", descending: false).getDocuments { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                for document in snapshot!.documents {
                    let description = document.data()["description"] as? String ?? "error"
                    let image = document.data()["image"] as? String ?? "error"
                    let name = document.data()["name"] as? String ?? "error"
                    let number = document.data()["number"] as? Int ?? 0
                    let url = document.data()["url"] as? String ?? "error"
                    let premium = document.data()["premium"] as? Bool ?? false
                    
                    self.audios.append(Audio(description: description, image: image, name: name, number: number, url: url, premium: premium))
                }
            }
        }
    }
}
