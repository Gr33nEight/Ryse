//
//  MainView.swift
//  Ryse
//
//  Created by Harry on 20.09.2020.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - PROPERTIES
    @Namespace var animation
    // MARK: - BODY
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Home")
                    
                }
            
            PlaylistListView()
                .tabItem {
                    Image(systemName: "waveform")
                    Text("Enviro")
                }

            AcademyView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Academy")
                }

//            MapView()
//                .tabItem {
//                    Image(systemName: "map")
//                    Text("Map")
//                }
//
            More()
                .tabItem {
                    Image(systemName: "slider.horizontal.3")
                    Text("Settings")
               }
        }.overlay (
            VStack{
                Spacer()
                AudioMiniPlayer(animation: animation)
            }.edgesIgnoringSafeArea(.bottom)
        )
    }
}

// MARK: - PREVIEW

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
