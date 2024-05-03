//
//  CircularImageView.swift
//  HeroWidget
//
//  Created by Mehmet Jiyan Atalay on 19.03.2024.
//

import SwiftUI

struct CircularImageView: View {
    
    var image : Image
    
    var body: some View {
        image.resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray,lineWidth: 5))
            .shadow(radius: 15)
    }
}

#Preview {
    CircularImageView(image: Image("batman"))
}
