//
//  ContentView.swift
//  Chapter10GyroApp
//
//  Created by Timur on 16.04.2023.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    
    @State private var x: Double = 0.0
    @State private var y: Double = 0.0
    @State private var z: Double = 0.0

    var body: some View {
        VStack{
            Text("x: \(x)")
            Text("y: \(y)")
            Text("z: \(z)")
        }.onAppear{
            motionManager.startGyroUpdates(to: queue) { (data : CMGyroData?, error : Error?) in
                guard let data = data else{
                    print("Error: \(error!)")
                    return
                }
                let trackMotion: CMRotationRate = data.rotationRate
                motionManager.gyroUpdateInterval = 2.5
                DispatchQueue.main.async {
                    x = trackMotion.x
                    y = trackMotion.y
                    z = trackMotion.z

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
