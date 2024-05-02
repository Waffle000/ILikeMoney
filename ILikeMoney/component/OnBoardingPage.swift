//
//  OnBoardingPage.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 24/03/24.
//

import SwiftUI

struct OnBoardingPage: View {
    var data : OnBoardingModel
    
    var body: some View {
        VStack(alignment: .center) {
            Image("\(data.imageUrl)")
                .resizable()
                .padding()
                .scaledToFit()
                .cornerRadius(16)
            Text(data.name)
                .font(.headline).padding(.top, 32)
            Text(data.description)
                .font(.subheadline).multilineTextAlignment(.center).padding(.top, 4)
        }
    }
}

#Preview {
    OnBoardingPage(data: OnBoardingModel.page)
}
