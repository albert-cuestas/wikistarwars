//
//  FilmsViewModel.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 19/2/22.
//

import Foundation

final class FilmsViewModel: ObservableObject {
    private let router: FilmsRouter
    private var navigate: Films?
    
    @Published private(set) var films: [Film] = []
    @Published private(set) var loading = true
    @Published private(set) var searching = false
    
    var last: Film? {
        self.films.last
    }
    
    init(router: FilmsRouter) {
        self.router = router
    }
    
    private func assign(_ search: Films) {
        self.navigate = search
        if self.films.isEmpty {
            self.films = search.results ?? []
        } else {
            self.films.append(contentsOf: search.results!)
        }
        self.films = self.films.sorted(by: { itemOne, itemTwo in
            itemOne.episodeID < itemTwo.episodeID
        })
    }
    
    private func setLoading(_ value: Bool) {
        DispatchQueue.main.async {
            self.loading = value
        }
    }
    
    func all(finished: @escaping (_ status: Bool) -> Void) {
        if !self.films.isEmpty {
            finished(true)
            return
        }
        self.setLoading(true)
        SwApiService.shared.all { (values: Films) in
            self.assign(values)
            self.setLoading(false)
            finished(true)
        } failure: { error in
            print(error ?? "Error call all")
            self.setLoading(false)
            finished(false)
        }
    }
    
    func search(query: String) {
        if query.isEmpty {
            self.films = []
            self.all { status in
                print(status)
            }
        } else {
            self.searching = true
            self.setLoading(true)
            SwApiService.shared.search(query: query) { (values: Films) in
                self.films = []
                self.assign(values)
                self.setLoading(false)
                self.searching = false
            }
        }
    }
    
    func hasNext() -> Bool {
        guard let url = navigate?.next else { return false }
        
        return !url.isEmpty
    }
    
    func next() {
        guard let url = navigate?.next else { return }
        
        if !url.isEmpty {
            self.setLoading(true)
            SwApiService.shared.execute(url: url) { (search: Films) in
                self.assign(search)
                self.setLoading(false)
            } failure: { error in
                print(error ?? "Error call next")
                self.setLoading(false)
            }
        }
    }
    
    func loadMore() {
        self.next()
    }
}
