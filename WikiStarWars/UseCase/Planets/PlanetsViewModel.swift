//
//  PlanetsViewModel.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 23/2/22.
//

import Foundation

final class PlanetsViewModel: ObservableObject {
    private let router: PlanetsRouter
    private var navigate: Planets?
    
    @Published private(set) var items: [Planet] = []
    @Published private(set) var loading = true
    @Published private(set) var searching = false
    
    var last: Planet? {
        self.items.last
    }
    
    init(router: PlanetsRouter) {
        self.router = router
    }
    
    private func assign(_ search: Planets) {
        self.navigate = search
        if self.items.isEmpty {
            self.items = search.results ?? []
        } else {
            self.items.append(contentsOf: search.results!)
        }
    }
    
    private func setLoading(_ value: Bool) {
        DispatchQueue.main.async {
            self.loading = value
        }
    }
    
    func all(finished: @escaping (_ status: Bool) -> Void) {
        if !self.items.isEmpty {
            finished(true)
            return
        }
        self.setLoading(true)
        SwApiService.shared.all { (values: Planets) in
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
            self.items = []
            self.all { status in
                print(status)
            }
        } else {
            self.searching = true
            self.setLoading(true)
            SwApiService.shared.search(query: query) { (values: Planets) in
                self.items = []
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
            SwApiService.shared.execute(url: url) { (search: Planets) in
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
