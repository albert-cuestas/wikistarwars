//
//  VehiclesView.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 24/2/22.
//

import SwiftUI

struct VehiclesView: View {
    @ObservedObject var viewModel: VehiclesViewModel
    
    private(set) var autoLoad: Bool = true
    
    var body: some View {
        GridView(delegate: self) {
            ForEach(viewModel.items, id: \.id) { (element: Vehicle) in
                NavigationLink {
                    GridDetailView(element: element) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Model").foregroundColor(.gray).bold()
                                Text("\(element.model)").font(.body)
                                Spacer()
                            }
                            VStack(alignment: .leading) {
                                Text("Manufacturer").foregroundColor(.gray).bold()
                                Text("\(element.manufacturer)").font(.body)
                            }
                            VStack(alignment: .leading) {
                                Text("Class").foregroundColor(.gray).bold()
                                Text("\(element.vehicleClass)").font(.body)
                            }
                            HStack {
                                Text("Cost").foregroundColor(.gray).bold()
                                Text("\(element.costInCredits) credits").font(.body)
                                Spacer()
                                Text("Speed").foregroundColor(.gray).bold()
                                Text("\(element.maxAtmospheringSpeed)").font(.body)
                            }
                            HStack {
                                Text("Length").foregroundColor(.gray).bold()
                                Text("\(element.length) m.").font(.body)
                                Spacer()
                                Text("Cargo Capacity").foregroundColor(.gray).bold()
                                Text("\(element.cargoCapacity)").font(.body)
                            }
                            HStack {
                                Text("Mimimum Crew").foregroundColor(.gray).bold()
                                Text("\(element.crew)").font(.body)
                                Spacer()
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
}

extension VehiclesView: SearchDelegate {
    var placeHolder: String {
        "Find your favorite vehicle"
    }
    
    func search(query: String) {
        viewModel.search(query: query)
    }
}

extension VehiclesView: GridViewDelegate {
    var title: String {
        ElementType.vehicle.title
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

struct VehiclesView_Previews: PreviewProvider {
    static var previews: some View {
        VehiclesRouter.view()
    }
}
