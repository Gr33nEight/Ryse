//
//  More.swift
//  Ryse
//
//  Created by Harry on 08/12/2021.
//

import SwiftUI

struct More: View {
    // MARK: - PROPERTIES
    
    @EnvironmentObject var toggleViewModel: ToggleViewModel
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0){
                //: MARK: - FORM
                
                Form {
                    //: MARK: - SECION 3
                    Section(header: Text("colour mode")) {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(Color.gray)
                                Image(systemName: toggleViewModel.isDark ? "moon.fill" : "sun.max.fill")
                                    .imageScale(.large)
                                    .foregroundColor(Color.white)
                            }
                            .frame(width: 36, height: 36, alignment: .center)
                            
                            Text("Theme").foregroundColor(Color.gray)
                            Spacer()
                            
                            Toggle(isOn: $toggleViewModel.isDark) {
                                Text("")
                            }
                            
                        }
                        .accentColor(Color(.systemGray2))
                    }
                    
                    Section(header: Text("Our Social Links")) {
                        MoreRowLinkView(icon: "globe", color: Color.green, text: "Instagram", link: "https:instagram.com/ryse.app")
                        MoreRowLinkView(icon: "camera.shutter.button.fill", color: Color.blue, text: "TikTok", link: "https://www.tiktok.com/@ryseapp?")
                    }  // END OF SECTION 3
                    
                    
                    //: MARK: - SECION 4
                    
                    Section(header: Text("Domestic Abuse Charities")) {
                        MoreRowLinkView(icon: "arrowshape.turn.up.right", color: Color.gray, text: "WomensAid", link: "https://www.womensaid.org.uk/")
                        MoreRowLinkView(icon: "arrowshape.turn.up.right", color: Color.gray, text: "Mankind", link: "https://www.mankind.org.uk")
                        MoreRowLinkView(icon: "arrowshape.turn.up.right", color: Color.gray, text: "NHS - Domestic violence", link: "https://www.nhs.uk/live-well/healthy-body/getting-help-for-domestic-violence/")
                        MoreRowLinkView(icon: "arrowshape.turn.up.right", color: Color.gray, text: "Refuge", link: "https://www.refuge.org.uk")
                    }  // END OF SECTION 4
                    .padding(.vertical, 3)
                    
                    //:    MARK: - SECTION 5
                    
                    Section(header: Text("About the application")) {
                        MoreButtonView(icon: "gear", firstText: "Application", secondText: "Ryse Fitness")
                        MoreButtonView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "Iphone")
                        MoreButtonView(icon: "keyboard", firstText: "Developer", secondText: "Harry Gwin")
                        MoreButtonView(icon: "paintbrush", firstText: "Content Producer", secondText: "Oisin Fenn")
                        MoreButtonView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                        MoreButtonView(icon: "person.circle.fill", firstText: "Copyright ©", secondText: "Ryse Fitess")
                        
                    } //: END OF SECITON 5
                    .padding(.vertical, 3)
                    
                } //: FORM
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                //.padding(.top, 10)
                .ignoresSafeArea()
                
                
                //: MARK: - FOOTER
                
                
            }//:END OF V STACK
            .navigationBarTitle("Settings")
            
        } //: NAVIGATION
    }
}

// MARK: - PREVIEW

struct More_Previews: PreviewProvider {
    static var previews: some View {
        More()
    }
}
