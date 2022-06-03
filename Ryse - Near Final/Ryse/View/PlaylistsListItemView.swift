//
//  VideoListItem.swift
//  Ryse
//
//  Created by Harry on 3.10.2020.
//

import SwiftUI

struct PlaylistsListItemView: View {
    
    // MARK: - PROPERTIES
    
    let isLessonPlaylis: Bool
    let playlist: Playlist
    let lessonPlaylist: LessonPlaylist
    // MARK: - BODY
    
    var body: some View {
        
        HStack(spacing: 10) {
            AsyncImage(
                url: URL(string: isLessonPlaylis ? lessonPlaylist.image : playlist.image)!,
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
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(isLessonPlaylis ? lessonPlaylist.name : playlist.name)
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Text(isLessonPlaylis ? lessonPlaylist.description : playlist.description)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .foregroundColor(.secondary)
            }
        }
    }
}

// MARK: - PREVIEW

//struct VideoListItem_Previews: PreviewProvider {
//
//    static let videos: [Video] = Bundle.main.decode("videos.json")
//
//    static var previews: some View {
//        VideoListItemView(video: videos[0])
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
