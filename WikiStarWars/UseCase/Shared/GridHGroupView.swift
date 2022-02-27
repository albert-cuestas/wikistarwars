//
//  GridHGroupView.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 20/2/22.
//

import SwiftUI

struct GridHGroupView: View {
    var title: String
    var items: [Displayable]
    var content: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 0) {
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(Color.lightbackgroundColor)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                Text(title).font(.title2.bold())
                    .padding([.bottom, .top], 5).foregroundColor(.white)
            }

            if !items.isEmpty && content {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(items, id: \.identifier) { element in
                            let urlimage: URL? = element.imageURL
                            let imageAlternative = Constants.defaultImageAlternative
                            GridBubleView(urlimage: urlimage, imageAlternative: imageAlternative, element: element)
                        }
                    }
                }
            } else {
                if items.isEmpty && !content {
                    HStack {
                        ActivityIndicator(size: 20, color: .red).padding(.leading, 5)
                        Text("Loading...").padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 20))
                        Spacer()
                    }.foregroundColor(.white)
                } else if items.isEmpty && content {
                    Text("There are no related items ").foregroundColor(.white).padding(EdgeInsets(top: 10, leading: 18, bottom: 10, trailing: 20))
                }
            }
        }
    }
}

struct GridHGroupView_Previews: PreviewProvider {
    static var previews: some View {
        GridHGroupView(title: "Vehicles", items: []).background(Color.lightbackgroundColor).previewLayout(.sizeThatFits)
        GridHGroupView(title: "Vehicles", items: [Vehicle.sample()!]).background(Color.lightbackgroundColor).preferredColorScheme(.dark).previewLayout(.sizeThatFits)
        GridHGroupView(title: "Vehicles", items: [Vehicle.sample()!]).background(Color.lightbackgroundColor).preferredColorScheme(.light).previewLayout(.sizeThatFits)
        GridHGroupView(title: "Vehicles", items: [Vehicle.empty()]).background(Color.lightbackgroundColor).previewLayout(.sizeThatFits)
    }
}
