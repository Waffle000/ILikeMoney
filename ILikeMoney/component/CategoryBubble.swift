//
//  CategoryBUbble.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 24/03/24.
//

import SwiftUI

struct CategoryBubble: View {
    
    let category: String
    
    var body: some View {
        Text(category)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .medium))
                    .cornerRadius(20)
    }
}

#Preview {
    CategoryBubble(category: "Coconut")
}
