//
//  ContentView.swift
//  Ryse
//
//  Created by Harry on 20.09.2020.
//

import SwiftUI
import Firebase
import MediaPlayer

struct ContentView: View {
    
    // MARK: - PROPERTIES
    
    @EnvironmentObject var recentAudioViewModel: RecentAudiosViewModel
    @EnvironmentObject var playlistsViewModel: PlaylistsViewModel
    @EnvironmentObject var audioPlayerViewModel: AudioPlayerViewModel
    @EnvironmentObject var storeManager: StoreManager
    @EnvironmentObject var toggleViewModel: ToggleViewModel
    
    //@State var currentPlaylist: Playlist
    @State var currentIndex = 1
    @State var showPremiumView = false
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    let animal: [Animal] = Bundle.main.decode("animals.json")
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        
        let x = proxy.frame(in: .global).minX
        
        let diff = abs(x - 55)
        if diff < 100 {
            scale = 1 + (110 - diff) / 500
        }
        return scale
    }
    
    private func showMore(proxy: GeometryProxy) -> Bool {
        var show: Bool = false
        
        let x = proxy.frame(in: .global).minX
        
        let diff = abs(x - 55)
        if diff < 100 {
            show.toggle()
        }
        return show
    }
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            GeometryReader { g in
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading){
                        ScrollView([.horizontal], showsIndicators: false){
                            HStack(alignment:.top, spacing: 50){
                                ForEach( playlistsViewModel.playlists.filter { return $0.isPicked }, id:\.self) { playlist in
                                    if playlist.premium {
                                        if UserDefaults.standard.bool(forKey: storeManager.myProducts.first?.productIdentifier ?? "") == true {
                                            NavigationLink(destination: AudioListView(audios: playlist.audios, currentPlaylist: playlist)) {
                                                GeometryReader { proxy in
                                                    let scale = getScale(proxy: proxy)
                                                    let show = showMore(proxy: proxy)
                                                    ZStack{
                                                        AsyncImage(
                                                            url: URL(string: playlist.image)!,
                                                            content: { image in
                                                                image.resizable()
                                                                    .aspectRatio(contentMode: .fill)
                                                                    .cornerRadius(15)
                                                                    .shadow(radius: show ? 0 : 20)
                                                            },
                                                            placeholder: {
                                                                ProgressView()
                                                            }
                                                        )
                                                    }
                                                    .scaleEffect(CGSize(width: scale, height: scale))
                                                }.frame(width: 300, height: 300)
                                            }
                                        }else{
                                            Button {
                                                showPremiumView = true
                                            } label: {
                                                GeometryReader { proxy in
                                                    let scale = getScale(proxy: proxy)
                                                    let show = showMore(proxy: proxy)
                                                    ZStack{
                                                        AsyncImage(
                                                            url: URL(string: playlist.image)!,
                                                            content: { image in
                                                                image.resizable()
                                                                    .aspectRatio(contentMode: .fill)
                                                                    .cornerRadius(15)
                                                                    .shadow(radius: show ? 0 : 20)
                                                            },
                                                            placeholder: {
                                                                ProgressView()
                                                            }
                                                        )
                                                    }
                                                    .scaleEffect(CGSize(width: scale, height: scale))
                                                }.frame(width: 300, height: 300)
                                            }
                                        }
                                    }else{
                                        NavigationLink(destination: AudioListView(audios: playlist.audios, currentPlaylist: playlist)) {
                                            GeometryReader { proxy in
                                                let scale = getScale(proxy: proxy)
                                                let show = showMore(proxy: proxy)
                                                ZStack{
                                                    AsyncImage(
                                                        url: URL(string: playlist.image)!,
                                                        content: { image in
                                                            image.resizable()
                                                                .aspectRatio(contentMode: .fill)
                                                                .cornerRadius(15)
                                                                .shadow(radius: show ? 0 : 20)
                                                        },
                                                        placeholder: {
                                                            ProgressView()
                                                        }
                                                    )
                                                }
                                                .scaleEffect(CGSize(width: scale, height: scale))
                                            }.frame(width: 300, height: 300)
                                        }
                                    }
                                }.sheet(isPresented: $showPremiumView) {
                                    PremiumView()
                                }
                            }
                            .padding(50)
                        }
                        Text("Most popular audios")
                            .font(.system(size: 18, weight: .semibold))
                            .padding(.horizontal)
                            .padding(.bottom, -20)
                            .zIndex(2)
                        List {
                            ForEach(recentAudioViewModel.audios) { audio in
                                Button {
                                    withAnimation {
                                        if audio.premium {
                                            if UserDefaults.standard.bool(forKey: storeManager.myProducts.first?.productIdentifier ?? "") == true {
                                                openAudioPlayer(audio: audio)
                                            }else{
                                                showPremiumView = true
                                            }
                                        }else{
                                            openAudioPlayer(audio: audio)
                                        }
                                    }
                                } label: {
                                    AudioListItemView(audio: audio)
                                        .foregroundColor(.white)
                                }
                                
                            }.sheet(isPresented: $showPremiumView) {
                                PremiumView()
                            }
                            
                        }.frame(width: g.size.width - 5, height: g.size.height - 10)
                            
                    }
                }.navigationBarTitle("Ryse Fitness", displayMode: .large)
                    .background(toggleViewModel.isDark ? Color.black : Color(UIColor.secondarySystemBackground))

            }
        }
    }
    func openAudioPlayer(audio: Audio) {
        audioPlayerViewModel.isRecentAudio = true
        
        if !audioPlayerViewModel.showBottomBar {
            audioPlayerViewModel.showBottomBar = true
        }
        audioPlayerViewModel.showFullScreen = true
        audioPlayerViewModel.currentAudio = audio
        audioPlayerViewModel.player.pause()
        let storage = Storage.storage().reference(forURL: self.audioPlayerViewModel.currentAudio!.url)
        storage.downloadURL { (url, error) in
            if error != nil {
                print(error!)
            }else{
                do{
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                    try AVAudioSession.sharedInstance().setActive(true)
                }catch{
                    
                }
                audioPlayerViewModel.player = MediaPlayer(url: url!)
                audioPlayerViewModel.player.play()
                
            }
        }
        audioPlayerViewModel.isPlaying = true
    }
}

// MARK: - PREVIEW
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
