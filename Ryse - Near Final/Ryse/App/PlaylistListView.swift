//
//  VideoListView.swift
//  Ryse
//
//  Created by Harry on 20.09.2020.
//

import SwiftUI

struct PlaylistListView: View {
    
    // MARK: - PROPERTIES
    
    @EnvironmentObject var storeManager: StoreManager
    @EnvironmentObject var playlistsViewModel: PlaylistsViewModel
    let hapticImpact = UIImpactFeedbackGenerator(style: .medium)
    @State var showPremiumView = false
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            List {
                ForEach(playlistsViewModel.playlists){ playlist in
                    if playlist.premium {
                        if UserDefaults.standard.bool(forKey: storeManager.myProducts.first?.productIdentifier ?? "") == true {
                            NavigationLink(destination: AudioListView(audios: playlist.audios, currentPlaylist: playlist)) {
                                PlaylistsListItemView(isLessonPlaylis: false, playlist: playlist, lessonPlaylist: LessonPlaylist(lessons: [], image: "", number: 0, name: "", description: "", premium: false))
                                    .padding(.vertical, 8)
                            }
                        }else{
                            Button {
                                showPremiumView = true
                            } label: {
                                HStack{
                                    PlaylistsListItemView(isLessonPlaylis: false, playlist: playlist, lessonPlaylist: LessonPlaylist(lessons: [], image: "", number: 0, name: "", description: "", premium: false))
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
                        NavigationLink(destination: AudioListView(audios: playlist.audios, currentPlaylist: playlist)) {
                            PlaylistsListItemView(isLessonPlaylis: false, playlist: playlist, lessonPlaylist: LessonPlaylist(lessons: [], image: "", number: 0, name: "", description: "", premium: false))
                                .padding(.vertical, 8)
                        }
                    }
                }.sheet(isPresented: $showPremiumView) {
                    PremiumView()
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Enviro Trainer", displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        playlistsViewModel.playlists.shuffle()
                        hapticImpact.impactOccurred()
                    }, label: {
                        
                    })
                }
            }
        }
    }
}

// MARK: - PREVIEW

//struct VideoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoListView()
//    }
//}

