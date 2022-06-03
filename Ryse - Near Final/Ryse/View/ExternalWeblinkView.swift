//
//  ExternalWeblinkView.swift
//  Ryse
//
//  Created by Harry on 2.10.2020.
//

import SwiftUI

struct ExternalWeblinkView: View {
    
    // MARK: - PROPERTIES
    
    let animal: Animal
    
    // MARK: - BODY
    
    var body: some View {
        GroupBox {
            HStack {
                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                Text("Follow us!")
                Spacer()
                
                Group {
                    Image(systemName: "arrow.up.right.square")
                    
                    Link("Our instagram", destination: (URL(string: animal.link) ?? URL(string: "www.instagram.com/ryse.app"))!)
                }
                .foregroundColor(.accentColor)
            }
        }
    }
}

// MARK: - PREVIEW

//struct ExternalWeblinkView_Previews: PreviewProvider {
//
//    static let animals: [Animal] = Bundle.main.decode("animals.json")
//
//    static var previews: some View {
//        ExternalWeblinkView(animal: animals[0])
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
