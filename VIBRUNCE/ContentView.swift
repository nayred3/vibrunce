//
//  ContentView.swift
//  VIBRUNCE
//
//  Created by Sri Kumbham on 2/23/22.
//


import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @EnvironmentObject var authentication: Authentication
    
    
    
    var body: some View {
        NavigationView {
            VStack {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .navigationTitle("Runner Location")
                .ignoresSafeArea()
                .accentColor(Color(.systemPink))
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

