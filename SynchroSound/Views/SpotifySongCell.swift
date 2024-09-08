//
//  SpotifySongCell.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/5/24.
//

import SwiftUI

struct SpotifySongCell: View {
    
    let track: SpotifyResponse.TrackObject
    let sampleTrack = MockSpotifyResponse.sampleResponse.tracks[0]
    
    var body: some View {
        ZStack {
            SpotifySongImage(imageURL: track.album.images.first?.url ?? sampleTrack.album.images[0].url)
                .frame(width: 160, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .scaledToFit()
            
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 160, height: 40)
                    .foregroundStyle(.brandLightBlue)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                
            }.frame(width: 160, height: 160)
            
            Text(track.name)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .lineLimit(1)
                .foregroundStyle(.white)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .frame(maxWidth: 160, maxHeight: 160, alignment: .bottomLeading)
                
            
            
        }
    }
}

struct SpotifySongImage: View {
    let imageURL: String
    
    var body: some View {
        NetworkManager.shared.downloadImage(from: imageURL)
    }
}

#Preview {
    SpotifySongCell(track: MockSpotifyResponse.sampleResponse.tracks[0])
}
