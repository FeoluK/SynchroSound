//
//  Model.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/5/24.
//

import SwiftUI

struct GoogleCloudVisionResponse: Codable {
    let responses: [Response]
    
    struct Response: Codable {
        let faceAnnotations: [FaceAnnotation]
    }
    
    struct FaceAnnotation: Codable {
        let joyLikelihood: String
        let sorrowLikelihood: String
        let angerLikelihood: String
        let surpriseLikelihood: String
    }
}
