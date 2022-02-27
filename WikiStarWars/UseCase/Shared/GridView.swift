//
//  GridView.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 16/2/22.
//

import SwiftUI

protocol GridViewDelegate: SearchDelegate {
    func all(finished: @escaping (_ status: Bool) -> Void)
    func more()
    func hasNext() -> Bool
    func isAutoLoad() -> Bool
    var title: String { get }
}

struct GridView<Content>: View where Content: View {
    var delegate: GridViewDelegate?
    let content: () -> Content

    @State private var finishLoad: Bool = false

    private let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    init(delegate: GridViewDelegate? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.delegate = delegate
        self.content = content
    }

    private func waiting() -> some View {
        VStack(alignment: .center) {
            ActivityIndicator(size: 55, color: .red, velocity: 7.0)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func gridView() -> some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    self.content()
                }.padding([.horizontal, .bottom])

                if let hasNext = delegate?.hasNext(), hasNext {
                    if let autoLoad = delegate?.isAutoLoad(), autoLoad {
                        ActivityIndicator(size: 45, color: .yellow)
                    } else {
                        Button {
                            self.delegate?.more()
                        } label: {
                            Text("Load more...")
                        }.frame(width: 150 * 2).padding()
                    }
                }
            } // scrollView
        }
        .padding(.top)
    }

    var body: some View {
        VStack {
            if finishLoad {
                HeaderSearchView(delegate: self)
                gridView().background {
                    Image("stars-clear").resizable().renderingMode(.original).scaledToFill()
                }
            } else {
                waiting()
            }
        }.task {
            delegate?.all { status in
                self.finishLoad = status
            }
        }.background(.black)
            .navigationTitle(delegate?.title ?? "")
            .navigationBarTitleDisplayMode(.large)
    }
}

extension GridView: SearchDelegate {
    var placeHolder: String {
        self.delegate?.placeHolder ?? "Find your favorite"
    }

    func search(query: String) {
        self.delegate?.search(query: query)
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView {
            EmptyView()
        }
    }
}
