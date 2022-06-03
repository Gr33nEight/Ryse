//
//  InsetFactView.swift
//  Ryse
//
//  Created by Harry on 2.10.2020.
//

import SwiftUI

struct InsetFactView: View {
    
    // MARK: - PROPERTIES
    
    let lesson: Lesson
    
    // MARK: - BODY
    
    var body: some View {
        GroupBox {
            TabView {
                ForEach(lesson.usefulTips, id: \.self) { item in
                    Text(item)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(minHeight: 148, idealHeight: 168, maxHeight: 180)
        }
    }
}

// MARK: - PREVIEW

//struct InsetFactView_Previews: PreviewProvider {
//
//    static let animals: [Animal] = Bundle.main.decode("animals.json")
//
//    static var previews: some View {
//        InsetFactView(animal: animals[0])
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
