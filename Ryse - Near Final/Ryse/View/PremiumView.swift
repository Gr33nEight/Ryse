//
//  PremiumView.swift
//  Ryse
//
//  Created by Harry  on 11/12/2021.
//

import SwiftUI

struct PremiumView: View {
    @EnvironmentObject var storeManager: StoreManager
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack{
                Text("Ryse Fitness")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.accentColor)
                    .padding(.bottom, 5)
                Text("Premium Version")
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
                Spacer()
                Image("center_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350)
                Text("Whats included?")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.accentColor)
                Text("Unlock all premium audios & lessons")
                    .padding(.top, 5)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                Text("Access to all future content")
                    .padding(.top, 2)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                Spacer()
                Button {
                    storeManager.purchaseProduct(product: storeManager.myProducts.first!)
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                        HStack{
                            Text("Total Price")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color.black)
                            Spacer()
                            Text("£9.99")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color.black)
                        }.foregroundColor(.white)
                        .padding()
                    }
                }.padding(.horizontal, 50)
                    .padding(.top, 5)
                    .frame(height: 65)
                HStack(spacing: 0.5){
                    Text("If you already purchased this, you can restore it ")
                        .font(.system(size: 13))
                        .foregroundColor(Color.white)
                    Button {
                        storeManager.restoreProducts()
                    } label: {
                        Text("HERE")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color.white)
                    }

                }
            

            }.padding(.top, 50)
                .padding(.bottom, 50)
        }
    }
}

