//
//  CircleImage.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 6/2/22.
//

import Kingfisher
import SwiftUI

struct CircleImage: View {
    var image: Image?
    var kImage: KFImage?

    var body: some View {
        if let limage = image {
            limage
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).padding(0)
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
        } else if let kimage = kImage {
            kimage
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).padding(0)
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image(systemName: "person"))
    }
}
