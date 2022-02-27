//
//  ActivityIndicator.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 13/2/22.
//

import SwiftUI

struct ActivityIndicator: View {
    @State var degress = 0.0
    @State private var timer: Timer?
    var size: CGFloat = .init(50)
    var color: Color = .init(red: 0, green: 0.1873417795, blue: 0.848551631)
    var velocity: Double = 5.0

    var body: some View {
        ZStack {
            Circle().stroke(.gray, lineWidth: 1.0).frame(width: size, height: size)
            Circle()
                .trim(from: 0.0, to: 0.6)
                .stroke(color, lineWidth: size < 50 ? 1 : 2.0)
                .frame(width: size, height: size)
                .rotationEffect(Angle(degrees: degress))
                .padding(5)
        }
        .onAppear { self.start() }
        .onDisappear { self.stop() }
    }

    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            withAnimation {
                self.degress += self.velocity
            }
            if self.degress == 360.0 {
                self.degress = 0.0
            }
        }
    }

    func stop() {
        if timer != nil {
            timer!.invalidate()
        }
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator(size: 160).previewLayout(.sizeThatFits)
        ActivityIndicator(size: 50).previewLayout(.sizeThatFits)
    }
}
