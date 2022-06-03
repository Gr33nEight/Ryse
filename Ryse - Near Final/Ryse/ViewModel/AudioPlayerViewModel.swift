//
//  AudioPlayerViewModel.swift
//  Ryse
//
//  Created by Harry  on 10/12/2021.
//

import Foundation
import MediaPlayer

class AudioPlayerViewModel: ObservableObject {
    @Published public var showBottomBar = false
    @Published public var showFullScreen = false
    @Published public var currentPlaylist : Playlist? = nil
    @Published public var currentAudio: Audio? = nil
    @Published public var isPlaying : Bool = false
    @Published public var player = MediaPlayer(url: URL(string: "") ?? URL(string: "gs://ryse-fitness.appspot.com/song.mp3")!)
    @Published public var isRecentAudio = false
}
