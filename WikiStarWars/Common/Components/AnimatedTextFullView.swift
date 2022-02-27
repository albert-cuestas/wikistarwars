//
//  AnimatedTextFullView.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 20/2/22.
//

import SwiftUI

struct AnimatedTextFullView: View {
    let text: String
    var font: Font = Font.custom("NewsCycle-Bold", size: 18).bold()
    let foregroundColor: Color

    @Binding var closeView: Bool
    @State private var animationStart = false
    @State private var animationEnd = false
    private let startAnimationDuration = 16.0
    private let endAnimationDuration = 1.5

    var body: some View {
        GeometryReader { geometryProxy in
            ZStack {
                Image("stars-bg-full").resizable().renderingMode(.original).scaleEffect().ignoresSafeArea()
                VStack {
                    ZStack {
                        VStack(spacing: 0) {
                            Spacer().background(.yellow)
                            RoundedRectangle(cornerRadius: 5).frame(width: 50, height: 4, alignment: .center).foregroundColor(.gray)
                            Spacer(minLength: 12)

                            GeometryReader { geo in
                                let _ = print(geo.size.height)
                                Button(action: {
                                    self.animationEnd = true
                                    self.closeView = false
                                    self.animationStart = false
                                }) {
                                    Image(systemName: "xmark.circle").resizable().renderingMode(.template).frame(width: 24, height: 24, alignment: .center)
                                }.frame(width: geo.size.width - 25, alignment: .trailing)
                                    .buttonStyle(.borderless)
                            }.tint(.white)
                        }

                        Text(text).font(font).foregroundColor(foregroundColor)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .lineSpacing(5)
                            .padding()
                            .rotation3DEffect(.degrees(animationEnd ? 0 : 60), axis: (x: 1, y: 0, z: 0))
                            .frame(width: 300, height: animationStart ? geometryProxy.size.height : 0)
                            .animation(Animation.linear(duration: startAnimationDuration), value: animationStart)

                            .onAppear {
                                self.animationStart.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + (self.startAnimationDuration * 1)) {
                                    self.animationEnd = true
                                    self.closeView = false
                                    self.animationStart = false
                                }
                            }
                    } // internal zstack
                }
            }
        }
        .onAppear {
            self.animationEnd = false
            self.animationStart = false
        }
    }
}

struct AnimatedTextFullView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedTextFullView(text: """
                             It is a period of civil war.\r\nRebel spaceships, striking\r\nfrom a hidden base, have won\r\ntheir first victory against\r\nthe evil Galactic Empire.\r\n\r\nDuring the battle, Rebel\r\nspies managed to steal secret\r\nplans to the Empire's\r\nultimate weapon, the DEATH\r\nSTAR, an armored space\r\nstation with enough power\r\nto destroy an entire planet.\r\n\r\nPursued by the Empire's\r\nsinister agents, Princess\r\nLeia races home aboard her\r\nstarship, custodian of the\r\nstolen plans that can save her\r\npeople and restore\r\nfreedom to the galaxy....",
                             """, font: Font.custom("Starjhol", size: 18),
                             foregroundColor: Color.starWarsColor, closeView: .constant(true))
    }
}
