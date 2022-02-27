//
//  HeaderSearchView.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 5/2/22.
//

import SwiftUI

struct HeaderSearchView: View {
//    var element: ElementType
    @ObservedObject var viewModel: HomeViewModel
    @Binding var fieldTextSearch: String
    @State private var isEditing: Bool = false
    @State private var isFocus: Bool = false

    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "magnifyingglass").renderingMode(.template)
                    .resizable().frame(width: 15, height: 15)
                    .foregroundColor(Color("TextColor"))
                    .padding(.leading, 16)
                    .opacity(0.5)

                TextField("Busca tu personaje favorito", text: $fieldTextSearch)
                    .padding(8).font(Font.system(size: 15))
                    .foregroundColor(Color("TextColor")).accentColor(Color("TextColor"))
                    .onTapGesture {
                        isFocus = true
                        isEditing = true
                    }.onChange(of: fieldTextSearch) { _ in
                        if !fieldTextSearch.isEmpty {
                            viewModel.search(query: fieldTextSearch)
                        }
                    }
                    .showClearButton($fieldTextSearch)

            }.background(Color("BackgroundColor")).clipShape(Capsule()).padding(16)

            if isEditing {
                Button(action: {
                    isEditing = false
                    isFocus = false
                    fieldTextSearch = ""
                    hideKeyboard()
                    viewModel.search(query: fieldTextSearch)
                }, label: { Text("Cancel") }).frame(height: 21)
                    .padding(.trailing, 15)
                    .foregroundColor(.blue)
            }
        }
        .background(Color(red: 0.1, green: 0.1, blue: 0.2))
        .onChange(of: fieldTextSearch) { _ in
            isEditing = !fieldTextSearch.isEmpty || isFocus
        }
    }
}

struct HeaderSearchView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderSearchView(viewModel: HomeViewModel(router: HomeRouter()), fieldTextSearch: .constant(""))
            .preferredColorScheme(.dark)
            .background(.orange)
            .previewLayout(.fixed(width: 400, height: 70))
        HeaderSearchView(viewModel: HomeViewModel(router: HomeRouter()), fieldTextSearch: .constant(""))
            .preferredColorScheme(.light)
            .background(.orange).opacity(0.7)
            .previewLayout(.fixed(width: 400, height: 70))
    }
}
