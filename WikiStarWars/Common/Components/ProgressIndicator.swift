//
//  ProgressIndicator.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 13/2/22.
//

import SwiftUI

struct ProgressIndicator: View {
    @Binding var progress: Double

    var body: some View {
        ProgressView("Loading...", value: progress, total: 100)
            .progressViewStyle(CustomCircularProgressViewStyle()).frame(width: 200, height: 200, alignment: .center).padding(10)
    }
}

struct CustomCircularProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                Circle()
                    .trim(from: 0.0, to: CGFloat(configuration.fractionCompleted ?? 0))
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 3, dash: [10, 5]))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 200)

                if let fractionCompleted = configuration.fractionCompleted {
                    Text(fractionCompleted < 1 ?
                        "Completed \(Int((configuration.fractionCompleted ?? 0) * 100))%"
                        : "Done!"
                    )
                    .fontWeight(.bold)
                    .foregroundColor(fractionCompleted < 1 ? .orange : .green)
                    .frame(width: 180)
                }
            }.padding().frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
}

struct ProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ProgressIndicator(progress: .constant(97))
    }
}
