//
//  AnimalListItemView.swift
//  Ryse
//
//  Created by Harry on 21.09.2020.
//

import SwiftUI

struct AudioListItemView: View {
    
    // MARK: - PROPERTIES
    
    let audio: Audio
    //var isLessonView: Bool
    
    // MARK: - BODY
    
    var body: some View {
        HStack {

            AsyncImage(
                url: URL(string: audio.image)!,
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 9)
                        )
                },
                placeholder: {
                    ProgressView()
                        .frame(width: 80, height: 80)
                }
            )
            
            VStack(alignment: .leading, spacing: 10, content: {
                
                Text(audio.name)
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Text(audio.description)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding(.trailing, 8)
                    .foregroundColor(.secondary)
            })
        }.padding(.vertical, 8)
    }
}

// MARK: - PREVIEW
//
//struct AnimalListItemView_Previews: PreviewProvider {
//
//    static let animal: [Animal] = Bundle.main.decode("animals.json")
//
//    static var previews: some View {
//        AnimalListItemView(animal: animal[1])
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
