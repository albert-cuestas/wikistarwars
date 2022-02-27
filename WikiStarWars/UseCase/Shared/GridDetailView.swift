//
//  GridDetailView.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 20/2/22.
//

import SwiftUI

struct GridDetailView<Content>: View where Content: View {
    let content: () -> Content
    
    let element: Displayable
    var heightElements: CGFloat = .init(130)
    @State var clickImage: Bool = false
    @State var characters: [People] = []
    @State var showCharacter = false
    @State var ships: [Starhip] = []
    @State var showShip = false
    @State var films: [Film] = []
    @State var showFilm = false
    @State var vehicles: [Vehicle] = []
    @State var showVehicle = false
    @State var species: [Specie] = []
    @State var showSpecie = false
    @State var planets: [Planet] = []
    @State var showPlanet = false
    
    @State var imageHeaderReduce: Bool = false
    @State var initialOffSet: CGFloat?
    
    private func transformImage(_ image: Image, width: CGFloat) -> some View {
        return image.resizable()
            .scaledToFit()
            .frame(width: width, height: width)
    }
    
    fileprivate func sheet(url: URL?, imageError: String, imageEmpty: String, binding: Binding<Bool>) -> some View {
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 5).frame(width: 50, height: 4, alignment: .center).background(.gray).foregroundColor(.gray).cornerRadius(5)
            
            GeometryReader { geo in
                if let imageUri: URL? = url,
                   let iExist = imageUri?.path.isEmpty, !iExist
                {
                    AsyncImage(url: imageUri) { phase in
                        if let image = phase.image {
                            image.resizable()
                                .scaledToFit()
                        } else if phase.error != nil {
                            Image(systemName: imageError).resizable().aspectRatio(contentMode: .fill).padding()
                                .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5, alignment: .center)
                                .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                        } else {
                            ActivityIndicator(color: .red).padding(60)
                        }
                    }.clipShape(RoundedRectangle(cornerRadius: 5)).padding(0)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5).stroke(.white, lineWidth: 3)
                        }
                        .shadow(radius: 7)
                        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else {
                    Image(systemName: imageEmpty)
                        .resizable().aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5, alignment: .center)
                        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
        }.onTapGesture {
            binding.wrappedValue = false
        }
    }
    
    fileprivate func loadData() {
        loadCharacters()
        loadStarShips()
        loadFilms()
        loadVehicles()
        loadSpecies()
        loadPlanets()
    }
    
    init(element: Displayable, @ViewBuilder content: @escaping () -> Content) {
        self.element = element
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            let widthBase: CGFloat = geometry.size.width * 0.5
            VStack {
                VStack {
                    Group {
                        if !element.url.isEmpty,
                           let imageUri: URL? = element.imageURL,
                           let iExist = imageUri?.path.isEmpty, !iExist
                        {
                            AsyncImage(url: imageUri) { phase in
                                if let image = phase.image {
                                    ZStack {
                                        CircleImage(image: image.resizable())
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: geometry.size.width * (!imageHeaderReduce ? 0.4 : 0.25),
                                                   height: geometry.size.width * (!imageHeaderReduce ? 0.4 : 0.25))
                                    
                                        Image(systemName: "plus.magnifyingglass").resizable().foregroundColor(.white)
                                            .frame(width: 50 * (!imageHeaderReduce ? 1 : 0.5), height: 50 * (!imageHeaderReduce ? 1 : 0.5)).shadow(radius: 7)
                                            .blendMode(.screen).opacity(0.8)
                                    
                                    }.compositingGroup().onTapGesture {
                                        clickImage = true
                                    }
                                } else if phase.error != nil {
                                    transformImage(Image(systemName: element.type.imageError), width: widthBase * (!imageHeaderReduce ? 0.5 : 0.45))
                                } else {
                                    ActivityIndicator(color: .red)
                                }
                            }
                        } else {
                            Image(systemName: element.type.imageEmpty).resizable().aspectRatio(contentMode: .fill)
                                .frame(width: widthBase * (!imageHeaderReduce ? 0.5 : 0.45), height: widthBase * (!imageHeaderReduce ? 0.5 : 0.45))
                        }
                    }.frame(width: geometry.size.width * (!imageHeaderReduce ? 0.4 : 0.25),
                            height: geometry.size.width * (!imageHeaderReduce ? 0.4 : 0.25))
                    Text(element.headline).font(.title.bold()).multilineTextAlignment(.leading).foregroundColor(.white)
                }
                .animation(.interactiveSpring(response: 0.75, dampingFraction: 0.9, blendDuration: 0.2), value: imageHeaderReduce)
                  
                Spacer(minLength: 5)
                
                ScrollView {
                    ZStack {
                        VStack {
                            dataStack

                            VStack {
                                if element.hasCharacters {
                                    groupCharacterView()
                                }
                                if element.hasFilms {
                                    GridHGroupView(title: ElementType.film.title, items: films, content: showFilm).frame(height: heightElements)
                                }
                                if element.hasStarships {
                                    GridHGroupView(title: ElementType.starShip.title, items: ships, content: showShip).frame(height: heightElements)
                                }
                                if element.hasVehicles {
                                    GridHGroupView(title: ElementType.vehicle.title, items: vehicles, content: showVehicle).frame(height: heightElements)
                                }
                                if element.hasSpecies {
                                    GridHGroupView(title: ElementType.specie.title, items: species, content: showSpecie).frame(height: heightElements)
                                }
                                if element.hasPlanets {
                                    GridHGroupView(title: ElementType.planet.title, items: planets, content: showPlanet).frame(height: heightElements)
                                }
                                Spacer(minLength: 15)
                            }
                            Spacer(minLength: 25)
                        }
                        
                        GeometryReader { proxy in
                            let offset = proxy.frame(in: .named("scroll")).minY
                            Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
                        }
                    } // zstack
                }.coordinateSpace(name: "scroll")
                    .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                        self.imageHeaderReduce = (value ?? 0) < 0
                    }
                
            }.padding().frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
        }
        .sheet(isPresented: $clickImage) {
            clickImage = false
        } content: {
            ZStack {
                Color.black.ignoresSafeArea()
                sheet(url: SwApiService.shared.imageUriBy(element: element.type, value: element.key()),
                      imageError: element.type.imageError, imageEmpty: element.type.imageEmpty, binding: $clickImage)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.backgroundColor)
        .task {
            loadData()
        }
    }
    
    private var dataStack: some View {
        VStack {
            self.content()
        }.padding(.bottom, 3)
            .foregroundColor(.white)
    }
    
    private func groupCharacterView() -> some View {
        var titleForCharacters: String = ElementType.people.title
        switch element.type {
            case .people, .homeworld, .film, .specie, .none:
                titleForCharacters = ElementType.people.title
            case .starShip, .vehicle:
                titleForCharacters = "Pilots"
            case .planet:
                titleForCharacters = "Residents"
        }
        
        return GridHGroupView(title: titleForCharacters, items: characters, content: showCharacter).frame(height: heightElements)
    }
    
    private func loadCharacters() {
        let uris: [String] = element.charactersUri
        if uris.isEmpty {
            showCharacter = true
            return
        }
        SwApiService.shared.fetchListOf(url: uris) { (value: [People]) in
            DispatchQueue.main.async {
                if value.isEmpty {
                    self.showCharacter = false
                } else {
                    self.characters = value
                }
                self.showCharacter = true
            }
        } failure: { _ in
            DispatchQueue.main.async {
                self.characters = []
                self.showCharacter = true
            }
        }
    }
    
    private func loadStarShips() {
        let uris: [String] = element.starshipsUri
        if uris.isEmpty {
            showShip = true
            return
        }
        
        SwApiService.shared.fetchListOf(url: uris) { (value: [Starhip]) in
            DispatchQueue.main.async {
                if value.isEmpty {
                    self.showShip = false
                } else {
                    self.ships = value.sorted(by: { (shipOne: Starhip, shipTwo: Starhip) in
                        shipOne.key() > shipTwo.key()
                    })
                }
                self.showShip = true
            }
        } failure: { _ in
            DispatchQueue.main.async {
                self.showShip = true
                self.ships = []
            }
        }
    }
    
    private func loadFilms() {
        let uris: [String] = element.filmsUri
        if uris.isEmpty {
            showFilm = true
            return
        }
        SwApiService.shared.fetchListOf(url: uris) { (value: [Film]) in
            DispatchQueue.main.async {
                if value.isEmpty {
                    self.showFilm = false
                } else {
                    self.films = value.sorted(by: { (shipOne: Film, shipTwo: Film) in
                        shipOne.episodeID > shipTwo.episodeID
                    })
                }
                self.showFilm = true
            }
        } failure: { _ in
            DispatchQueue.main.async {
                self.showFilm = true
                self.films = []
            }
        }
    }
    
    private func loadVehicles() {
        let uris: [String] = element.vehiclesUri
        if uris.isEmpty {
            showVehicle = true
            return
        }
        SwApiService.shared.fetchListOf(url: uris) { (value: [Vehicle]) in
            DispatchQueue.main.async {
                if value.isEmpty {
                    self.showVehicle = false
                } else {
                    self.vehicles = value.sorted(by: { (shipOne: Vehicle, shipTwo: Vehicle) in
                        shipOne.key() > shipTwo.key()
                    })
                }
                self.showVehicle = true
            }
        } failure: { _ in
            DispatchQueue.main.async {
                self.vehicles = []
                self.showVehicle = true
            }
        }
    }
    
    private func loadSpecies() {
        let uris: [String] = element.speciesUri
        if uris.isEmpty {
            showSpecie = true
            return
        }
        SwApiService.shared.fetchListOf(url: uris) { (value: [Specie]) in
            DispatchQueue.main.async {
                if value.isEmpty {
                    self.showSpecie = false
                } else {
                    self.species = value.sorted(by: { (shipOne: Specie, shipTwo: Specie) in
                        shipOne.key() > shipTwo.key()
                    })
                }
                self.showSpecie = true
            }
        } failure: { _ in
            DispatchQueue.main.async {
                self.species = []
                self.showSpecie = true
            }
        }
    }
    
    private func loadPlanets() {
        let uris: [String] = element.planetsUri
        if uris.isEmpty {
            showPlanet = true
            return
        }
        SwApiService.shared.fetchListOf(url: uris) { (value: [Planet]) in
            DispatchQueue.main.async {
                if value.isEmpty {
                    self.showPlanet = false
                } else {
                    self.planets = value.sorted(by: { (shipOne: Planet, shipTwo: Planet) in
                        shipOne.key() > shipTwo.key()
                    })
                }
                self.showPlanet = true
            }
        } failure: { _ in
            DispatchQueue.main.async {
                self.planets = []
                self.showPlanet = true
            }
        }
    }
}

private struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat? = nil
    
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}

struct GridDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GridDetailView(element: People.sample()!) {
            VStack {
                Text("sample data")
            }
        }
    }
}
