//
//  AudioPlayerView.swift
//  Ryse
//
//  Created by Harry  on 09/12/2021.
//

import Firebase
import SwiftUI
import MediaPlayer
import Combine

struct AudioMiniPlayer : View {
    var animation: Namespace.ID
    var screenW = UIScreen.main.bounds.width
    var screenH = UIScreen.main.bounds.height
    var height = UIScreen.main.bounds.height / 3
    
    
    @State var offsetPlayer : CGFloat = 0
    @State var value: Double = 0
    
    
    @Environment(\.colorScheme) var theme
    @EnvironmentObject var audioPlayer: AudioPlayerViewModel
    
    var body: some View {
        if audioPlayer.showBottomBar{
            ZStack{
                if audioPlayer.showFullScreen{
                    VStack{
                        AsyncImage(
                            url: URL(string: audioPlayer.currentAudio!.image)!,
                            content: { image in
                                image.resizable()
                                    .interpolation(Image.Interpolation.high)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: screenW, height: screenH * 0.55)
                                    .cornerRadius(15)
                                
                            },
                            placeholder: {
                                ProgressView()
                                    .frame(width: screenW * 0.66, height: screenH * 0.7)
                            }
                        ).contentShape(Rectangle())
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: .black, location: 0),
                                        .init(color: .clear, location: 0.4)
                                    ]),
                                    startPoint: .bottom,
                                    endPoint: .top
                                ), alignment: .bottom
                            )
                        Spacer()
                    }
                }
                VStack{
                    if audioPlayer.showFullScreen{
                        HStack{
                            Button {
                                withAnimation {
                                    audioPlayer.showFullScreen = false
                                }
                            } label: {
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 25, weight: .semibold))
                                    .foregroundColor(.accentColor)
                                    .padding()
                            }
                            
                            Spacer()
                        }
                        .zIndex(10)
                        Spacer()
                    }
                    HStack(spacing: 15){
                        if audioPlayer.showFullScreen{Spacer(minLength: 0)}
                        
                        if !audioPlayer.showFullScreen{
                            
                            AsyncImage(
                                url: URL(string: audioPlayer.currentAudio!.image)!,
                                content: { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 55, height: 55)
                                        .cornerRadius(15)
                                },
                                placeholder: {
                                    ProgressView()
                                        .frame(width: 55, height: 55)
                                }
                            )
                            
                            VStack(alignment: .leading){
                                
                                Text(audioPlayer.currentAudio?.name ?? "error")
                                    .font(.system(size: 15, weight: .semibold))
                                    .matchedGeometryEffect(id: "Label", in: animation)
                                    .padding(.vertical, 2)
                                    .foregroundColor(.accentColor)
                                
                            }
                        }
                        
                        Spacer(minLength: 0)
                        
                        if !audioPlayer.showFullScreen{
                            
                            HStack{
                                Button(action: {
                                    withAnimation {
                                        playPause()
                                    }
                                }, label: {
                                    
                                    Image(systemName: audioPlayer.isPlaying ? "pause.fill"  : "play.fill")
                                        .font(.title2)
                                        .foregroundColor(.accentColor)
                                        .padding(5)
                                })
                                
                                Button(action: {
                                    withAnimation {
                                        audioPlayer.showBottomBar = false
                                        audioPlayer.player.pause()
                                    }
                                }, label: {
                                    
                                    Image(systemName: "xmark")
                                        .font(.title2)
                                        .foregroundColor(.accentColor)
                                        .padding(5)
                                })
                            }
                        }
                    }.padding(.top, 25)
                    .padding(.horizontal)
                    
                    VStack(){
                        
                        if audioPlayer.showFullScreen{
                            Spacer()
                            VStack{
                                Text(audioPlayer.currentAudio?.name ?? "error")
                                    .font(.system(size: 25, weight: .semibold))
                                    .foregroundColor(.white)
                                    .matchedGeometryEffect(id: "Label", in: animation)
                                    .padding(.bottom, 10)
                                if !audioPlayer.isRecentAudio{
                                    Text(audioPlayer.currentPlaylist?.name ?? "error")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.white)
                                        .matchedGeometryEffect(id: "Label2", in: animation)
                                }
                                
                                SliderView(player: audioPlayer.player)
                                    .padding()
                                
                            }
                            
                        }
                        
                        if audioPlayer.showFullScreen{
                            
                            HStack(spacing: 20){
                                Button(action: {
                                    previous()
                                }, label: {
                                    if !audioPlayer.isRecentAudio{
                                        Image(systemName: "backward.fill")
                                            .font(.largeTitle)
                                            .foregroundColor(.accentColor)
                                            .padding(5)
                                    }
                                })
                                Button(action: {
                                    withAnimation {
                                        playPause()
                                    }
                                }, label: {
                                    
                                    Image(systemName: audioPlayer.isPlaying ? "pause.fill"  : "play.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.accentColor)
                                        .padding(5)
                                })
                                
                                Button(action: {
                                    next()
                                }, label: {
                                    if !audioPlayer.isRecentAudio{
                                        Image(systemName: "forward.fill")
                                            .font(.largeTitle)
                                            .foregroundColor(.accentColor)
                                            .padding(5)
                                    }
                                })
                            }.padding(.top)
                        }
                        //Spacer(minLength: 0)
                        
                    }
                    .padding([.vertical, .bottom], 80)
                    .frame(height: audioPlayer.showFullScreen ? nil : 0)
                    .opacity(audioPlayer.showFullScreen ? 1 : 0)
                    
                }.padding(.bottom)
            }
            .onAppear(perform: {
                if audioPlayer.showBottomBar{
                    playSong()
                }
            })
            .frame(maxHeight: audioPlayer.showFullScreen ? .infinity : screenW/5.5)
            .background(
                
                VStack(spacing: 0){
                    if audioPlayer.showFullScreen{
                        Color(theme == .light ? .white : .black)
                    }else{
                        BlurView()
                    }
                }
                    .onTapGesture(perform: {
                        
                        withAnimation(.spring()){audioPlayer.showFullScreen = true}
                    })
            )
            .cornerRadius(audioPlayer.showFullScreen ? 20 : 0)
            .offset(y: audioPlayer.showFullScreen ? 0 : -screenW/5)
            .offset(y: offsetPlayer)
            .gesture(DragGesture().onEnded(onended(value:)).onChanged(onchanged(value:)))
            .ignoresSafeArea()
        }
    }
    
    func onchanged(value: DragGesture.Value){
        if value.translation.height > 0 && audioPlayer.showFullScreen {
            
            offsetPlayer = value.translation.height
        }
    }
    
    func onended(value: DragGesture.Value){
        
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)){
            if value.translation.height > height{
                
                audioPlayer.showFullScreen = false
            }
            offsetPlayer = 0
        }
    }
    func playSong(){
        let storage = Storage.storage().reference(forURL: self.audioPlayer.currentAudio!.url)
        storage.downloadURL { (url, error) in
            if error != nil {
                print(error!)
            }else{
                //let item = AVPlayerItem(url: url!)
                do{
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                    try AVAudioSession.sharedInstance().setActive(true)
                }catch{
                    
                }
                audioPlayer.player = MediaPlayer(url: url!)
                audioPlayer.player.play()
                audioPlayer.isPlaying = true
            }
        }
    }
    func playPause(){
        audioPlayer.isPlaying.toggle()
        if audioPlayer.isPlaying == false{
            audioPlayer.player.pause()
        }else{
            audioPlayer.player.play()
        }
    }
    func next(){
        
        
        if let currentIndex = audioPlayer.currentPlaylist!.audios.firstIndex(of: audioPlayer.currentAudio!){
            if currentIndex == audioPlayer.currentPlaylist!.audios.count - 1 {
                
            }else{
                audioPlayer.player.pause()
                audioPlayer.currentAudio! = audioPlayer.currentPlaylist!.audios[currentIndex + 1]
                self.playSong()
                audioPlayer.isPlaying.toggle()
            }
        }
        
        
        
    }
    func previous(){
        if let currentIndex = audioPlayer.currentPlaylist!.audios.firstIndex(of: audioPlayer.currentAudio!) {
            if currentIndex == 0{
                
            }else{
                audioPlayer.player.pause()
                audioPlayer.currentAudio! = audioPlayer.currentPlaylist!.audios[currentIndex - 1]
                self.playSong()
                audioPlayer.isPlaying.toggle()
            }
        }
    }
}


class MediaPlayer {
    var player: AVPlayer
    var currentTimePublisher: PassthroughSubject<Double, Never> = .init()
    var currentProgressPublisher: PassthroughSubject<Float, Never> = .init()
    private var playerPeriodicObserver: Any?
    
    init(url: URL) {
        player = AVPlayer(url: url)
        setupPeriodicObservation(for: player)
    }
    
    private func setupPeriodicObservation(for player: AVPlayer) {
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
        
        playerPeriodicObserver = player.addPeriodicTimeObserver(forInterval: time, queue: .main) { [weak self] (time) in
            guard let `self` = self else { return }
            let progress = self.calculateProgress(currentTime: time.seconds)
            self.currentProgressPublisher.send(progress)
            self.currentTimePublisher.send(time.seconds)
        }
    }
    
    private func calculateProgress(currentTime: Double) -> Float {
        return Float(currentTime / duration)
    }
    
    private var duration: Double {
        return player.currentItem?.duration.seconds ?? 0
    }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func seek(to time: CMTime) {
        player.seek(to: time)
    }
    
    func seek(to percentage: Float) {
        let time = convertFloatToCMTime(percentage)
        player.seek(to: time)
    }
    
    private func convertFloatToCMTime(_ percentage: Float) -> CMTime {
        return CMTime(seconds: duration * Double(percentage), preferredTimescale: CMTimeScale(NSEC_PER_SEC))
    }
}

class PlayerSliderViewModel: ObservableObject {
    @Published var progressValue: Float = 0
    
    var player: MediaPlayer
    var acceptProgressUpdates = true
    var subscriptions: Set<AnyCancellable> = .init()
    
    init(player: MediaPlayer) {
        self.player = player
        listenToProgress()
    }
    
    private func listenToProgress() {
        player.currentProgressPublisher.sink { [weak self] progress in
            guard let self = self,
                  self.acceptProgressUpdates else { return }
            self.progressValue = progress
        }.store(in: &subscriptions)
    }
    
    func didSliderChanged(_ didChange: Bool) {
        acceptProgressUpdates = !didChange
        if didChange {
            player.pause()
        } else {
            player.seek(to: progressValue)
            player.play()
        }
    }
}

struct SliderView: View {
    @ObservedObject var viewModel: PlayerSliderViewModel
    init(player: MediaPlayer) {
        viewModel = .init(player: player)
    }
    
    var body: some View {
        HStack{
            Slider(value: $viewModel.progressValue) { didChange in
                viewModel.didSliderChanged(didChange)
            }
        }
    }
}
