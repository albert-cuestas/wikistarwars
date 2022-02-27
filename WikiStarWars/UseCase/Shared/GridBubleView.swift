//
//  GridBubleView.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 20/2/22.
//

import Kingfisher
import SwiftUI

struct GridBubleView: View {
    var urlimage: URL?
    var imageAlternative: String? = Constants.defaultImageAlternative
    var element: Displayable
    
    @State private var clickBuble: Bool = false
    @State var failImage = false
    
    var alternativeImageView: some View {
        Image(systemName: imageAlternative!).resizable().foregroundColor(.white).scaledToFit().frame(width: 40, height: 40, alignment: .center)
    }
    
    var body: some View {
        HStack {
            VStack(spacing: 0) {
                if let imageUri = urlimage,
                   let iExist = imageUri.path.isEmpty, !iExist
                {
                    if !failImage {
                        KFImage.url(imageUri)
                            .placeholder {
                                ProgressView()
                            }.onFailure { (_: KingfisherError) in
                                self.failImage = true
                            }
                            .resizable().renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 104, height: 72, alignment: .topLeading)
                            .clipped()
                    } else {
                        alternativeImageView
                    }
                } else {
                    alternativeImageView
                }
            }
            .frame(width: 104, height: 72)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .strokeBorder(.white, lineWidth: 1)
            )
            
            VStack(alignment: .leading) {
                Text(element.headline)
                    .foregroundColor(.white)
                    .font(.headline)
                
                Text(element.subHeadLine)
                    .foregroundColor(Color.secondaryDark)
                    .font(.subheadline)
            }.frame(minWidth: 80, maxWidth: 140, alignment: .leading).padding(.leading, 2)
        }.padding([.horizontal, .bottom])
            .onTapGesture {
                clickBuble = true
            }
            .sheet(isPresented: $clickBuble) {
                clickBuble = false
            } content: {
                ZStack {
                    Color.black.ignoresSafeArea()
                    sheetPresent(url: urlimage, binding: $clickBuble)
                }
            }
    }
    
    fileprivate func sheetPresent(url: URL?, binding: Binding<Bool>, imageError: String? = Constants.defaultImageAlternative,
                                  imageEmpty: String? = Constants.defaultImageAlternative) -> some View
    {
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 5).frame(width: 50, height: 4, alignment: .center).background(.gray).foregroundColor(.gray).cornerRadius(5)
            Text(element.headline).font(.title2.bold()).padding(.horizontal).foregroundColor(.white)
            GeometryReader { geo in
                if let imageUri: URL? = url,
                   let iExist = imageUri?.path.isEmpty, !iExist
                {
                    AsyncImage(url: imageUri) { phase in
                        if let image = phase.image {
                            image.resizable()
                                .scaledToFit()
                        } else if phase.error != nil {
                            Image(systemName: imageError!).resizable().aspectRatio(contentMode: .fill).padding()
                                .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5, alignment: .center)
                                .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15)).foregroundColor(.white)
                        } else {
                            ProgressView()
                        }
                    }.clipShape(RoundedRectangle(cornerRadius: 5)).padding(0)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5).stroke(.white, lineWidth: 3)
                        }
                        .shadow(radius: 7)
                        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else {
                    Image(systemName: imageEmpty!)
                        .resizable().aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5, alignment: .center)
                        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center).foregroundColor(.white)
                }
            }
        }.onTapGesture {
            binding.wrappedValue = false
        }
    }
}

struct GridBubleView_Previews: PreviewProvider {
    static let element: People? = People.sample()
    static var previews: some View {
        GridBubleView(urlimage: URL(string: element!.imageUri), element: element!.self)
    }
}
