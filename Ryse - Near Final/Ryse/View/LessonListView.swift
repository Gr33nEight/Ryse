//
//  LessonListView.swift
//  Ryse
//
//  Created by Harry  on 10/12/2021.
//

import SwiftUI

struct LessonListView: View {
    
    let lessons: [Lesson]
    
    var body: some View {
        
        List{
            ForEach(lessons){ lesson in
                NavigationLink {
                    LessonDetailView(lesson: lesson)
                } label: {
                    HStack(spacing: 10) {
                        AsyncImage(
                            url: URL(string: lesson.image)!,
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
                            
                            Text(lesson.intro)
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.accentColor)
                            
                            
                            Text(lesson.heading)
                                .font(.footnote)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                                .foregroundColor(.gray)
                        }
                    }.padding(.vertical, 8)
                }
                
            }
        }.padding(.bottom, 200)
    }
}
