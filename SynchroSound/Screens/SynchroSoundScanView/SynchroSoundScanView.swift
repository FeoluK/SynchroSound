import SwiftUI
import UIKit

struct SynchroSoundScanView: View {
    @StateObject var viewModel =  SynchroSoundScanViewModel()
    
    var body: some View {
        ZStack {
            SynchroSoundBackground()
            
            VStack {
                SynchroSoundTitle()
                
                Spacer()
                
                Text(viewModel.detectedEmotion)
                    .font(.title2)
                    .padding()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                
                Spacer()
                
                Button {
                    viewModel.showCamera = true
                } label: {
                    SynchroSoundSymbolCircle(symbol: "camera.viewfinder", description: "")
                }
                .padding(.bottom, 60)
            }
        }
        .fullScreenCover(isPresented: $viewModel.showCamera) {
            CameraView(isPresented: $viewModel.showCamera, selectedImage: $viewModel.selectedImage)
                .ignoresSafeArea()
                .onDisappear {
                    if let image = viewModel.selectedImage {
                        viewModel.detectEmotion(from: image)
                    }
                }
        }
    }
    
    
}

#Preview {
    SynchroSoundScanView()
}


//for face in faceAnnotations {
//    if let joyLikelihood = face["joyLikelihood"] as? String {
//        emotionProbabilities += "Joy: \(joyLikelihood)\n"
//    }
//    if let sorrowLikelihood = face["sorrowLikelihood"] as? String {
//        emotionProbabilities += "Sorrow: \(sorrowLikelihood)\n"
//    }
//    if let angerLikelihood = face["angerLikelihood"] as? String {
//        emotionProbabilities += "Anger: \(angerLikelihood)\n"
//    }
//    if let surpriseLikelihood = face["surpriseLikelihood"] as? String {
//        emotionProbabilities += "Surprise: \(surpriseLikelihood)\n"
//    }
//}
