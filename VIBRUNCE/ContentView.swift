//
//  ContentView.swift
//  VIBRUNCE
//
//  Created by Sri Kumbham on 2/23/22.
//


import MapKit
import SwiftUI



let MapLocations = [
    
        MapLocation(name: "G1", latitude: 29.750016614480156, longitude: -95.36205451727514),
        
        MapLocation(name: "G2", latitude: 29.754484435765075, longitude: -95.35733038319792),
        
        MapLocation(name: "G3", latitude: 29.754127273446475, longitude: -95.36210844752735)
        
        ]

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @EnvironmentObject var authentication: Authentication
    
    
   
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                Map(coordinateRegion: $viewModel.region, interactionModes: MapInteractionModes.all, showsUserLocation: true, annotationItems: MapLocations, annotationContent: { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        LocationMapAnnotationView()
                    }
                  })
                .navigationTitle("Runner Location")
                .ignoresSafeArea()
                .accentColor(Color(.systemCyan))
                .onAppear {
                    viewModel.checkIfLocationServicesIsEnabled()
                }
                NavigationLink(destination: Text("Group Averages \n \n Pace: 8:20 \n \n Total Distance: 3.4 \n \n Elevation Change: 20 Feet \n \n Top Speed: 7 MPH \n \n Calories Burnt: 383")
                                .bold()
                                .lineLimit(nil)
                                .font(.system(size: 27.0)), label: {
                    Text("Group Running Stats")
                        .bold()
                        .background(Color.teal)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                })
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Log out") {
                        authentication.updateValidation(success: false)
                        
                    }
                }
            }
        }
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

