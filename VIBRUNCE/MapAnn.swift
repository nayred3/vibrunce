//
//  MapAnn.swift
//  VIBRUNCE
//
//  Created by Sri Kumbham on 2/19/22.
//

import Foundation
import MapKit

struct MapLocation: Identifiable {
    
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
