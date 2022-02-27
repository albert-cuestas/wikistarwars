//
//  StarshipsView.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 20/2/22.
//

import SwiftUI

struct StarshipsView: View {
    @ObservedObject var viewModel: StarshipsViewModel
    
    private(set) var autoLoad: Bool = true
    
    var body: some View {
        GridView(delegate: self) {
            ForEach(viewModel.items, id: \.id) { (element: Starhip) in
                NavigationLink {
                    GridDetailView(element: element) {
                        VStack(alignment: .leading, spacing: 8) {
                            VStack(alignment: .leading) {
                                Text("Model").foregroundColor(.gray).bold()
                                Text("\(element.model)").font(.body)
                            }
                            VStack(alignment: .leading) {
                                Text("Manufacturer").foregroundColor(.gray).bold()
                                Text("\(element.manufacturer)").font(.body)
                            }
                            VStack(alignment: .leading) {
                                Text("Class").foregroundColor(.gray).bold()
                                Text("\(element.starshipClass)").font(.body)
                            }
                            HStack {
                                Text("Cost").foregroundColor(.gray).bold()
                                Text(UIUtils.parseNumberFormatString(element.costInCredits, unit: " credits")).font(.body)
                            }
                            HStack {
                                Text("Speed").foregroundColor(.gray).bold()
                                Text(speedFormatString(element.maxAtmospheringSpeed)).font(.body)
                            }
                            HStack {
                                Text("Hyperdrive Rating").foregroundColor(.gray).bold()
                                Text("\(element.hyperdriveRating)").font(.body)
                                Spacer()
                                Text("MGLT").foregroundColor(.gray).bold()
                                Text("\(element.mglt)").font(.body)
                            }
                            HStack {
                                Text("Length").foregroundColor(.gray).bold()
                                Text("\(element.length)").font(.body)
                            }
                            HStack {
                                Text("Cargo").foregroundColor(.gray).bold()
                                Text(cargoFormatString(element.cargoCapacity)).font(.body)
                            }
                            HStack {
                                Text("Mimimum Crew").foregroundColor(.gray).bold()
                                Text("\(element.crew)").font(.body)
                            }
                            HStack {
                                Text("Passengers").foregroundColor(.gray).bold()
                                Text("\(element.passengers)").font(.body)
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
    
    private func speedFormatString(_ value: String) -> String {
        if !value.isEmpty {
            if value.contains("n/a") {
                return value
            }
            
            if value.contains("km") {
                return value.replacingOccurrences(of: "km", with: "km/h")
            }
            
            return "\(value)km/h"
        }
        return value
    }
    
    private func cargoFormatString(_ value: String) -> String {
        if !value.isEmpty, let cargo = Int(value) {
            if cargo > 1000 {
                return ("\(cargo / 1000) metric tons")
            } else {
                return ("\(cargo) kg")
            }
        }
        return value
    }
}

extension StarshipsView: SearchDelegate {
    var placeHolder: String {
        "Find your favorite starship"
    }
    
    func search(query: String) {
        viewModel.search(query: query)
    }
}

extension StarshipsView: GridViewDelegate {
    var title: String {
        ElementType.starShip.title
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

struct StarshipsView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipsRouter.view()
    }
}
