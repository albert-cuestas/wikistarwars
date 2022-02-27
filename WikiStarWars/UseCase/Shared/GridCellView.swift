//
//  GridCellView.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 20/2/22.
//

import Accelerate
import Kingfisher
import SwiftUI

struct GridCellView: View {
    let element: Displayable
    @State var failImage = false

    var body: some View {
        ZStack {
            Color.backgroundColor

            VStack {
                Group {
                    if !failImage {
                        KFImage.url(element.imageURL).cancelOnDisappear(true)
                            .placeholder {
                                ActivityIndicator(size: 45, color: .red).padding()
                            }.onFailure { (_: KingfisherError) in
                                self.failImage = true
                            }.resizable().renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 95, height: 95, alignment: .topLeading).clipped().cornerRadius(10)
                    } else {
                        Image(systemName: Constants.defaultImageAlternative).resizable().renderingMode(.original)
                            .aspectRatio(contentMode: .fill).frame(width: 40, height: 40).tint(.white)
                    }
                }

                .frame(width: 100, height: 100).scaleEffect(1).offset(x: 0, y: 0)
                .frame(width: 100, height: 100).scaleEffect(1)
                .cornerRadius(10).frame(width: 100, height: 100).scaledToFit().padding()

                Text(element.headline)
                    .foregroundColor(.white)
                    .font(.caption).padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(Color.lightbackgroundColor)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10).stroke(.white)
        }
    }
}

struct GridCellView_Previews: PreviewProvider {
    static var previews: some View {
        GridCellView(element: People.sample()!)
    }
}
