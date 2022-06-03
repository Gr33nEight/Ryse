//
//  MoreRowLinkView.swift
//  Ryse
//
//  Created by Harry on 09/12/2021.
//

import SwiftUI

struct MoreRowLinkView: View {
    //: MARK: - PROPERTIES
    
    var icon: String
    var color: Color
    var text: String
    var link: String
    
    //: MARK: - BODY
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(Color.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(text).foregroundColor(Color.gray)
            Spacer()
            
            Button(action: {
                // OPEN LINK
                guard let url = URL(string: self.link), UIApplication.shared.canOpenURL(url) else {
                    return
                }
                UIApplication.shared.open(url as URL)
            }) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
        }
            .accentColor(Color(.systemGray2))
        }
    }
}

//: MARK: - PREVIEW

struct MoreRowLinkView_Previews: PreviewProvider {
    static var previews: some View {
        MoreRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "https:instagram.com/ryse.app")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
