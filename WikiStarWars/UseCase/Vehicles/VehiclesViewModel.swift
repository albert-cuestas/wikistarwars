//
//  VehiclesViewModel.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 24/2/22.
//

import Foundation

final class VehiclesViewModel: ObservableObject {
    private let router: VehiclesRouter
    private var navigate: Vehicles?
    
    @Published private(set) var items: [Vehicle] = []
    @Published private(set) var loading = true
    @Published private(set) var searching = false
    
    var last: Vehicle? {
        self.items.last
    }
    
    init(router: VehiclesRouter) {
        self.router = router
    }
    
    private func assign(_ search: Vehicles) {
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
        SwApiService.shared.all { (values: Vehicles) in
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
            SwApiService.shared.search(query: query) { (values: Vehicles) in
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
            SwApiService.shared.execute(url: url) { (search: Vehicles) in
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
