//
//  VideoListView.swift
//  Ryse
//
//  Created by Harry on 20.09.2020.
//

import SwiftUI

struct AcademyView: View {
    
    // MARK: - PROPERTIES
    
    @EnvironmentObject var lessonPlaylistViewModel: LessonPlaylistViewModel
    @EnvironmentObject var storeManager: StoreManager
    
    @State var showPremiumView = false
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            List {
                ForEach(lessonPlaylistViewModel.lessonPlaylists) { lessonPlaylist in
                    
                    if lessonPlaylist.premium {
                        if UserDefaults.standard.bool(forKey: storeManager.myProducts.first?.productIdentifier ?? "") == true {
                            NavigationLink(destination: LessonListView(lessons: lessonPlaylist.lessons)) {
                                PlaylistsListItemView(isLessonPlaylis: true, playlist: Playlist(audios: [], image: "", number: "0", name: "", description: "", premium: false, isPicked: false), lessonPlaylist: lessonPlaylist)
                                    .padding(.vertical, 8)
                            }
                        }else{
                            Button {
                                showPremiumView = true
                            } label: {
                                HStack{
                                    PlaylistsListItemView(isLessonPlaylis: true, playlist: Playlist(audios: [], image: "", number: "0", name: "", description: "", premium: false, isPicked: false), lessonPlaylist: lessonPlaylist)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(.gray.opacity(0.5))
                                        .padding(.top, 6)
                                }
                                    .padding(.vertical, 8)
                            }.foregroundColor(.white)
                        }
                    }else{
                        NavigationLink(destination: LessonListView(lessons: lessonPlaylist.lessons)) {
                            PlaylistsListItemView(isLessonPlaylis: true, playlist: Playlist(audios: [], image: "", number: "0", name: "", description: "", premium: false, isPicked: false), lessonPlaylist: lessonPlaylist)
                                .padding(.vertical, 8)
                        }
                    }
                }.sheet(isPresented: $showPremiumView) {
                    PremiumView()
                }
            }
            .navigationBarTitle("Academy", displayMode: .large)
        }
    }
}

// MARK: - PREVIEW

struct Academy_Previews: PreviewProvider {
    static var previews: some View {
        AcademyView()
    }
}
