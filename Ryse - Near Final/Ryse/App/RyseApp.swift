//
//  RyseApp.swift
//  Ryse
//
//  Created by Harry on 20.09.2020.
//

import SwiftUI
import Firebase

@main
struct Ryseapp: App {
    
    @ObservedObject var recentAudiosViewModel = RecentAudiosViewModel()
    @ObservedObject var playlistsViewModel = PlaylistsViewModel()
    @ObservedObject var lessonPlaylistViewModel = LessonPlaylistViewModel()
    @ObservedObject var audioPlayerViewModel = AudioPlayerViewModel()
    
    @StateObject var toggleViewModel = ToggleViewModel()
    @StateObject var storeManager = StoreManager()
    
    let productIDs = [
            ""
        ]
    
    init() {
        FirebaseApp.configure()
        
        recentAudiosViewModel.loadData()
        playlistsViewModel.loadData()
        lessonPlaylistViewModel.loadData()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(toggleViewModel).environmentObject(recentAudiosViewModel).environmentObject(playlistsViewModel).environmentObject(lessonPlaylistViewModel).environmentObject(audioPlayerViewModel).environmentObject(storeManager).onAppear(perform: {storeManager.getProducts(productIDs: productIDs)})
                .preferredColorScheme(toggleViewModel.isDark ? .dark : .light)
        }
    }
}

