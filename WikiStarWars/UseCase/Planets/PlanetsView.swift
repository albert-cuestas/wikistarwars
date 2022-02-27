//
//  PlanetsView.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 23/2/22.
//

import SwiftUI

struct PlanetsView: View {
    @ObservedObject var viewModel: PlanetsViewModel
    
    private(set) var autoLoad: Bool = true
    
    var body: some View {
        GridView(delegate: self) {
            ForEach(viewModel.items, id: \.id) { (element: Planet) in
                NavigationLink {
                    GridDetailView(element: element) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Population").foregroundColor(.gray).bold()
                                Text("\(element.population)").font(.body)
                            }
                            HStack {
                                Text("Rotation Period").foregroundColor(.gray).bold()
                                Text(UIUtils.parseNumberFormatString(element.rotationPeriod, unit: " days")).font(.body)
                            }
                            HStack {
                                Text("Orbital Period").foregroundColor(.gray).bold()
                                Text(UIUtils.parseNumberFormatString(element.orbitalPeriod, unit: " days")).font(.body)
                            }
                            HStack {
                                Text("Diameter").foregroundColor(.gray).bold()
                                Text(UIUtils.parseNumberFormatString(element.diameter, unit: "km")).font(.body)
                            }
                            HStack {
                                Text("Gravity").foregroundColor(.gray).bold()
                                Text("\(element.gravity)").font(.body)
                            }
                            VStack(alignment: .leading) {
                                Text("Terrain").foregroundColor(.gray).bold()
                                Text("\(element.terrain)").font(.body)
                            }
                            HStack {
                                Text("Surface Water").foregroundColor(.gray).bold()
                                Text(UIUtils.parseNumberFormatString(element.surfaceWater, unit: "%")).font(.body)
                            }
                            HStack {
                                Text("Climate").foregroundColor(.gray).bold()
                                Text("\(element.climate)").font(.body)
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

extension PlanetsView: SearchDelegate {
    var placeHolder: String {
        "Find your favorite planets"
    }
    
    func search(query: String) {
        viewModel.search(query: query)
    }
}

extension PlanetsView: GridViewDelegate {
    var title: String {
        ElementType.planet.title
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

struct PlanetsView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetsRouter.view()
    }
}
