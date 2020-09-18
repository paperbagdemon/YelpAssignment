//
//  Stub.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/17/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation

struct Stub {
    static let testPhotoURL = "https://vignette.wikia.nocookie.net/sd-smash/images/1/1d/Catto.jpg/revision/latest?cb=20190328215620"
    static let testBusinessID = "sFKF4eyP6DKdr2o1qpykig"
    static func sampleBusiness() -> Business {
        return Business(id: "sFKF4eyP6DKdr2o1qpykig", name: "Lola Basyang's", imageUrl: "https://s3-media1.fl.yelpcdn.com/bphoto/zVCoHsMZebOXgM9uZDIWKw/o.jpg",
        isClosed: nil, url: nil, price: "₱₱", phone: "+639228177570",
        displayPhone: "+639228177570", photos: nil, rating: 4.5,
        reviewCount: nil, categories: [Category.init(alias: "Filipino", title: "Filipino"),
        Category.init(alias: "Seafood", title: "Seafood"),
        Category.init(alias: "Fruit", title: "Fruit"),
        Category.init(alias: "Meat", title: "Meat"),
        Category.init(alias: "Street", title: "Street"),
        Category.init(alias: "Meal", title: "Meal")],
        distance: 300000,
        coordinates: Coordinates.init(latitude: 14.675525, longitude: 121.0437512),
        location: Location(addressOne: "Jupiter Street", addressTwo: "G/F, Executive Building", addressThree: nil, city: "Makati", state: "NCR", zipCode: "", country: "PH",
        displayAddress: ["Jupiter Street", "G/F, Executive Building", "Makati, Metro Manila", "Philippines"],
        crossStreets: nil), transactions: nil, hours: [Hour.init(hoursType: "Regular",
        open: [Open.init(isOvernight: true, start: "1000", end: "2100", day: 0),
        Open.init(isOvernight: true, start: "1000", end: "2100", day: 1),
        Open.init(isOvernight: true, start: "1000", end: "2100", day: 2),
        Open.init(isOvernight: true, start: "1000", end: "2100", day: 3),
        Open.init(isOvernight: true, start: "1000", end: "2100", day: 4),
        Open.init(isOvernight: true, start: "1000", end: "2100", day: 5)])])
    }
}
