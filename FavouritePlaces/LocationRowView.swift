//
//  LocationRowView.swift
//  FavouritePlaces
//
//  Created by Jack Brighton on 12/5/22.
//

import SwiftUI

struct LocationRowView: View {
    @ObservedObject var location: Location
    @State var image = Image(systemName: "map").resizable()
    
    var body: some View {
        HStack {
            image.aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 25, alignment: .center)
            Text(location.name ?? "")
        } .task {
            image = await location.getImage()
        }
    }
}

