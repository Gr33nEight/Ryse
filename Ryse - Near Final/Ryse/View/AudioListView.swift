//
//  AudioListView.swift
//  Ryse
//
//  Created by Harry  on 10/12/2021.
//

import SwiftUI
import Firebase
import MediaPlayer

struct AudioListView: View {
    
    let audios: [Audio]
    @EnvironmentObject var audioPlayerViewModel: AudioPlayerViewModel
    @State var currentPlaylist : Playlist
    
    var body: some View {
        List{
            ForEach(audios){ audio in
                Button {
                    withAnimation {
                        audioPlayerViewModel.isRecentAudio = false
                        audioPlayerViewModel.currentPlaylist = currentPlaylist
                        
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
                } label: {
                    HStack(spacing: 10) {
                        ZStack {
                            
                            AsyncImage(
                                url: URL(string: audio.image)!,
                                content: { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(9)
                                },
                                placeholder: {
                                    ProgressView()
                                        .frame(width: 80, height: 80)
                                }
                            )
                            Image(systemName: "play.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 32)
                                .shadow(radius: 4)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text(audio.name)
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(Color.primary)
                            
                            Text(audio.description)
                                .font(.footnote)
                                .foregroundColor(Color.secondary)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                        }
                    }.padding(.vertical, 8)
                }.foregroundColor(.white)
            }
        }
    }
}

//struct AudioListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AudioListView()
//    }
//}
