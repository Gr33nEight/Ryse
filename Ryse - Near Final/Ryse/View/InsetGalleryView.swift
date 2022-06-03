//
//  InsetGalleryView.swift
//  Ryse
//
//  Created by Harry on 2.10.2020.
//

import SwiftUI

struct InsetGalleryView: View {
    
    // MARK: - PROPERTIES
    
    let lesson: Lesson
    
    // MARK: - BODY
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 15) {
                ForEach(lesson.stepByStep, id: \.self) { item in
                    AsyncImage(
                        url: URL(string: lesson.image)!,
                        content: { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(12)                        },
                        placeholder: {
                            ProgressView()
                                .frame(width: 200, height: 200)
                        }
                    )
                }
            }
        }
    }
}

// MARK: - PREVIEW

//struct InsetGalleryView_Previews: PreviewProvider {
//
//    static let animals: [Animal] = Bundle.main.decode("animals.json")
//
//    static var previews: some View {
//        InsetGalleryView(animal: animals[0])
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
