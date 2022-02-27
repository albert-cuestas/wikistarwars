//
//  HomeView.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 4/2/22.
//

// imatges https://starwars-visualguide.com/assets/img/characters/$IDCHARACTER.jpg
// https://github.com/tbone849/star-wars-guide

// color btn FF6899  back 565DFF

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var shape = RoundedRectangle(cornerRadius: 16, style: .continuous)

    private func cardView(destination: AnyView, name: String, image: String) -> some View {
        NavigationLink(destination: destination) {
            GeometryReader { geo in
                VStack {
                    Image(image).renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .topLeading)
                        .scaleEffect(x: 1)

                    ZStack {
                        Rectangle().background(.red).frame(maxWidth: .infinity, maxHeight: 30).blendMode(.normal).opacity(0.6)
                        Text(name.uppercased())
                            .padding(.horizontal, 8)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.white)
                            .rotationEffect(.degrees(0))
                            .opacity(1)
                            .blendMode(.overlay)
                            .animatableFont(size: 25, weight: .bold)
                            .minimumScaleFactor(0.25)
                            .offset(.zero)
                    }
                    .offset(CGSize(width: -0, height: -43))
                    .frame(minHeight: 40)
                }
            }
            .frame(minWidth: 130, minHeight: 130)
            .compositingGroup()
            .clipShape(shape)
            .overlay {
                shape
                    .inset(by: 0.5)
                    .stroke(.quaternary, lineWidth: 0.5)
            }
            .contentShape(shape)
            .shadow(color: .white, radius: 2, x: 1, y: 1)
        }
        .navigationTitle("Categories")
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(StackNavigationViewStyle())
    }

    var body: some View {
        NavigationView {
            GeometryReader { g in
                ZStack {
                    Color.backgroundColor.ignoresSafeArea()
                    Image("stars-clear").resizable().renderingMode(.original).scaleEffect().ignoresSafeArea()

                    VStack(alignment: .center, spacing: 10) {
                        Image("starwars-logo").renderingMode(.original).resizable().scaledToFit().frame(width: 150, alignment: .topLeading)

                        VStack(alignment: .leading, spacing: 0) {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 130), spacing: 16, alignment: .top)], alignment: .center, spacing: 16) {
                                ForEach(Categories.allCases, id: \.self) { category in
                                    cardView(destination: category.destination, name: category.name, image: category.icon)
                                }
                            }.padding(.horizontal, 10).frame(width: g.size.width, alignment: .center).padding(.vertical)
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeRouter.view().preferredColorScheme(.dark)
        HomeRouter.view().preferredColorScheme(.light)
    }
}
