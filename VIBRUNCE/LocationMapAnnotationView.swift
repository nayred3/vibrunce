//
//  LocationMapAnnotationView.swift
//  VIBRUNCE
//
//  Created by Sri Kumbham on 2/19/22.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    
    let accentColor = Color(.systemCyan)
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "figure.walk.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(accentColor)
                .clipShape(Circle())
            
        }
    }
}

struct LocationMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapAnnotationView()
    }
}
