//
//  BusinessSearchViewModel.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/19/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation
import MapboxGeocoder
import Combine
enum SuggestType {
    case term
    case location
    case category
    case none
}

final class BusinessSearchBarViewModel: ObservableObject {
    private var bag = Set<AnyCancellable>()
    private var locationService: LocationService!
    @Published var categoryQuery: String = ""
    @Published var termQuery: String = ""
    @Published var locationQuery: String = ""
    @Published private(set) var locations: (value: [GeocodedPlacemark]?, error: Error?)
    @Published var suggestType: SuggestType = .term

    convenience init(locationService: LocationService) {
        self.init()
        self.locationService = locationService
        self.$categoryQuery.sink { _ in
            self.suggestType = .category
        }
        .store(in: &bag)
        self.$termQuery.sink { _ in
            self.suggestType = .term
        }
        .store(in: &bag)
        self.$locationQuery.sink { _ in
            self.suggestType = .location
        }
        .store(in: &bag)
    }

    func getLocations(term: String) {
        locationService.getLocations(term: term).sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                self.locations = (nil, error)
                self.objectWillChange.send()
            case .finished: ()
            }
        }, receiveValue: { value in
            self.locations = (value, nil)
            self.objectWillChange.send()
        })
        .store(in: &bag)
    }
}
