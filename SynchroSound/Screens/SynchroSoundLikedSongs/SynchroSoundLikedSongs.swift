//
//  SynchroSoundLikedSongs.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/10/24.
//
import SwiftUI
import SwiftData

struct SynchroSoundLikedSongs: View {
    @Query var users: [User]
    
    let email: String
    let name: String
    
    var user: User? {
        users.first { $0.email == email && $0.name == name }
    }

    var body: some View {
        if let user = user {
            List(user.favoriteSongs, id: \.self) { song in
                VStack(alignment: .leading) {
                    Text(song.name)
                        .font(.headline)
                }
            }
            .navigationTitle("Liked Songs")
            .navigationBarTitleDisplayMode(.inline)
        } else {
            Text("No liked songs found for this user.")
                .navigationTitle("Liked Songs")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    SynchroSoundLikedSongs(email: "olufeolu@gmail.com", name: "Feolu")
        .modelContainer(for: User.self)
}
