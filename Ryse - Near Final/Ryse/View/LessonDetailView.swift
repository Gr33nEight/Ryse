//
//  AnimalDetailView.swift
//  Ryse
//
//  Created by Harry on 2.10.2020.
//

import SwiftUI

struct LessonDetailView: View {
    
    // MARK: - PROPERTIES
    
    let lesson: Lesson
    
    // MARK: - BODY
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .center, spacing: 20) {
                
                // HEROIMAGE
                AsyncImage(
                    url: URL(string: lesson.image)!,
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    },
                    placeholder: {
                        ProgressView()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                    }
                )
                
                // TITLE
                Text(lesson.intro.uppercased())
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 8)
                    .foregroundColor(.primary)
                    .background(
                        Color.accentColor
                            .frame(height: 6)
                            .offset(y: 24)
                    )
                
                // HEADLINE
                Text(lesson.heading)
                    .font(.headline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.accentColor)
                    .padding(.horizontal)
                
                // GALLERY
                Group {
                    HeadingView(headingImage: "photo.on.rectangle.angled", headingText: "Step by step")
                    
                    InsetGalleryView(lesson: lesson)
                }
                .padding(.horizontal)
                

                
                
                // FACTS
                Group {
                    HeadingView(headingImage: "questionmark.circle", headingText: "Instructions")
                    InsetFactView(lesson: lesson)
                }
                .padding(.horizontal)
                
                
                
                
                
                
                
                // DESCRIPTION
                Group {
                    HeadingView(headingImage: "info.circle", headingText: "More info")
                    
                    Text(lesson.details)
                        .multilineTextAlignment(.leading)
                        .layoutPriority(1)
                }
               .padding(.horizontal)
                
                // LINK
//                Group {
//                    HeadingView(headingImage: "books.vertical", headingText: "Discover More")
//
//                    ExternalWeblinkView(lesson: lesson)
//                }
//                .padding(.horizontal)
            }.padding(.bottom, 100)
            .navigationBarTitle("Academy", displayMode: .inline)
        }
    }
}

// MARK: - PREVIEW

//struct AnimalDetailView_Previews: PreviewProvider {
//
//    static let animals: [Animal] = Bundle.main.decode("animals.json")
//
//    static var previews: some View {
//        NavigationView {
//            AnimalDetailView(animal: animals[0])
//        }
//    }
//}
