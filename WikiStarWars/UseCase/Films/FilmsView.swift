//
//  FilmsView.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 19/2/22.
//

import SwiftUI

struct FilmsView: View {
    @ObservedObject var viewModel: FilmsViewModel
    
    private(set) var autoLoad: Bool = true
    @State private var openCrawl = false
    
    var body: some View {
        GridView(delegate: self) {
            ForEach(viewModel.films, id: \.id) { (element: Film) in
                NavigationLink {
                    GridDetailView(element: element) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Episode").foregroundColor(.gray).bold()
                                Text("\(element.episodeID)").font(.body)
                                Spacer()
                                Text("Date created").foregroundColor(.gray).bold()
                                Text("\(element.releaseDate)").font(.body)
                            }
                            HStack {
                                Text("Producer").foregroundColor(.gray).bold()
                                Text("\(element.producer)").font(.body)
                            }
                            HStack {
                                Text("Director").foregroundColor(.gray).bold()
                                Text("\(element.director)").font(.body)
                            }
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Opening crawl").foregroundColor(.gray).bold()
                                    Image(systemName: "rectangle.expand.vertical")
                                }
                                
                                GeometryReader { geo in
                                    VStack(alignment: .center, spacing: 1) {
                                        Text(element.openingCrawl).lineLimit(5).truncationMode(.tail).font(.body).padding(.bottom, 1).padding(0).frame(width: geo.size.width, alignment: .center)
                                        Text("more...").font(.footnote).foregroundColor(Color.starWarsColor).padding(0).frame(width: geo.size.width, alignment: .trailing)
                                    }.padding(0).frame(alignment: .center)
                                    
                                }.frame(height: 130).padding(0)
                            }.onTapGesture {
                                self.openCrawl = true
                            }
                            
                        }.padding().frame(maxWidth: .infinity, alignment: .leading).lineLimit(nil).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity)
                    }.sheet(isPresented: $openCrawl) {
                        self.openCrawl = false
                    } content: {
                        AnimatedTextFullView(text: element.openingCrawl, font: Font.custom("NewsCycle-Bold", size: 18).bold(), foregroundColor: Color.starWarsColor, closeView: $openCrawl)
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

extension FilmsView: SearchDelegate {
    var placeHolder: String {
        "Find your favorite film"
    }
    
    func search(query: String) {
        viewModel.search(query: query)
    }
}

extension FilmsView: GridViewDelegate {
    var title: String {
        "Films"
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

struct FilmsView_Previews: PreviewProvider {
    static var previews: some View {
        FilmsRouter.view()
    }
}
