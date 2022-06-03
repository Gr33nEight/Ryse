//
//  PlaylistsViewModel.swift
//  Ryse
//
//  Created by Harry  on 09/12/2021.
//

import Foundation
import Firebase

class PlaylistsViewModel: ObservableObject {
    @Published public var playlists = [Playlist]()
    
    func loadData() {
        Firestore.firestore().collection("Playlists").order(by: "number", descending: false).getDocuments { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                for document in snapshot!.documents {
                    let image = document.data()["image"] as? String ?? "error"
                    let name = document.data()["name"] as? String ?? "error"
                    let description = document.data()["description"] as? String ?? "error"
                    let number = document.data()["number"] as? String ?? "0"
                    let premium = document.data()["premium"] as? Bool ?? true
                    let isPicked = document.data()["isPicked"] as? Bool ?? false
                    let audios = document.data()["audios"] as? [String : [String : Any]]
                    
                    var audioArray = [Audio]()
                    if let audios = audios {
                        for audio in audios {
                            let description = audio.value["description"] as? String ?? "error"
                            let image = audio.value["image"] as? String ?? "error"
                            let name = audio.value["name"] as? String ?? "error"
                            let number = audio.value["number"] as? Int ?? 1
                            let url = audio.value["url"] as? String ?? "error"
                            
                            audioArray.append(Audio(description: description, image: image, name: name, number: number, url: url, premium: false))
                            audioArray.sort { $1.number > $0.number }
                        }
                    }
                    
                    self.playlists.append(Playlist(audios: audioArray, image: image, number: number, name: name, description: description, premium: premium, isPicked: isPicked))
                }
            }
        }
    }
}
