//
//  SpeciesView.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 24/2/22.
//

import SwiftUI

struct SpeciesView: View {
    @ObservedObject var viewModel: SpeciesViewModel
    
    private(set) var autoLoad: Bool = true
    
    var body: some View {
        GridView(delegate: self) {
            ForEach(viewModel.items, id: \.id) { (element: Specie) in
                NavigationLink {
                    GridDetailView(element: element) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Classification").foregroundColor(.gray).bold()
                                Text("\(element.classification)").font(.body)
                                Spacer()
                            }
                            VStack(alignment: .leading) {
                                Text("Designation").foregroundColor(.gray).bold()
                                Text("\(element.designation)").font(.body)
                            }
                            VStack(alignment: .leading) {
                                Text("Language").foregroundColor(.gray).bold()
                                Text("\(element.language)").font(.body)
                            }
                            HStack {
                                Text("Avg Lifespan").foregroundColor(.gray).bold()
                                Text("\(element.averageLifespan) ").font(.body)
                                Spacer()
                                Text("Avg Height").foregroundColor(.gray).bold()
                                Text("\(element.averageHeight)").font(.body)
                            }
                            HStack {
                                Text("Hair Color(s)").foregroundColor(.gray).bold()
                                Text("\(element.hairColors)").font(.body)
                            }
                            HStack {
                                Text("Skin Color(s)").foregroundColor(.gray).bold()
                                Text("\(element.skinColors)").font(.body)
                            }
                            HStack {
                                Text("Eye Color(s)").foregroundColor(.gray).bold()
                                Text("\(element.eyeColors)").font(.body)
                            }
                        }.padding().frame(maxWidth: .infinity, alignment: .leading).lineLimit(nil).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity)
                    }
                } label: {
                    GridCellView(element: element)
                }.task {
                    if element == viewModel.last, autoLoad {
                        viewModel.loadMore()
                    }
                }
            }
        }
    }
}

extension SpeciesView: SearchDelegate {
    var placeHolder: String {
        "Find your favorite specie"
    }
    
    func search(query: String) {
        viewModel.search(query: query)
    }
}

extension SpeciesView: GridViewDelegate {
    var title: String {
        ElementType.specie.title
    }
    
    func all(finished: @escaping (Bool) -> Void) {
        viewModel.all(finished: finished)
    }
    
    func more() {
        viewModel.loadMore()
    }
    
    func hasNext() -> Bool {
        return viewModel.hasNext()
    }
    
    func isAutoLoad() -> Bool {
        autoLoad
    }
}

struct SpeciesView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesRouter.view()
    }
}
