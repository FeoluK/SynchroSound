//
//  SynchroSoundMoodDetailView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/19/24.
//

import SwiftUI
import Charts

struct MoodData: Identifiable {
    let id = UUID()
    let emotion: String
    let value: Float
}

struct SynchroSoundMoodDetailView: View {
    let moods: [MoodData]
    var normalizedMoods: [MoodData] {
        let total = moods.reduce(0) { $0 + $1.value }
        
        return moods.map { mood in
            MoodData(emotion: mood.emotion, value: mood.value / total)
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.85)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Mood Breakdown")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(15)
                    .shadow(radius: 10)
                    .opacity(0.9)
                
                Chart(normalizedMoods, id: \.id) { mood in
                    SectorMark(
                        angle: .value("Value", mood.value),
                        innerRadius: .ratio(0.5),
                        outerRadius: .ratio(1.0)
                    )
                    .foregroundStyle(by: .value("Emotion", mood.emotion))
                    .opacity(0.8)
                    .shadow(radius: 10)
                }
                .chartLegend(.hidden)
                .frame(height: 300)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
                )
                .padding(.bottom, 20)
                
                List(normalizedMoods, id: \.id) { mood in
                    HStack {
                        Text(mood.emotion)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Spacer()
                        Text("\(Int(mood.value * 100))%")
                            .foregroundStyle(.white)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(10)
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .opacity(0.9)
                .shadow(radius: 5)
                .padding(.horizontal, 10)
            }
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    SynchroSoundMoodDetailView(moods: [
        MoodData(emotion: "Joy", value: 0.75),
        MoodData(emotion: "Sadness", value: 0.5),
        MoodData(emotion: "Anger", value: 0.25),
        MoodData(emotion: "Surprise", value: 0.05)
    ])
    .environmentObject(LoginState())
}
