//
//  TargetZoneView.swift
//  targetzone Watch App
//
//  Created by admin on 4/17/24.
//

import SwiftUI

struct TargetZoneView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var backgroundColor: Color = .clear
    @Binding var targetZone: Double
    
    var body: some View {
        VStack(alignment: .center) {
            Text("TARGET ZONE")
                .font(.system(size: 20, weight: .bold))
                .padding()
            
            Text("\(String(format: "%.1f", targetZone))")
                .font(.system(size: 60, weight: .bold))
                .padding()
            let currentZone = self.workoutManager.zone
            Text("CURRENT ZONE: \(String(format: "%.1f", currentZone))")
                .font(.system(size: 18, weight: .bold))
                .onAppear {
                    if self.targetZone == self.workoutManager.zone {
                        DispatchQueue.global().async {
                            FeedbackManager.shared.achieveTargetZone()
                        }
                    }
                }
            
            if targetZone > currentZone {
                Text("GO FASTER!")
                    .font(.system(size: 18, weight: .bold))
                    .onAppear {
                        DispatchQueue.global().async {
                            FeedbackManager.shared.runningTooSlow()
                        }
                    }
            }
            
            if targetZone < currentZone {
                Text("GO SLOWER!")
                    .font(.system(size: 18, weight: .bold))
                    .onAppear {
                        DispatchQueue.global().async {
                            FeedbackManager.shared.runningTooFast()
                        }
                    }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .onAppear() {
            updateUI()
        }
        .onChange(of: self.workoutManager.zone) {
            updateUI()
        }
    }
    
    private func updateUI() {
        let currentZone = self.workoutManager.zone
        let tolerance: Double = 0.5 // Adjust this value as needed
        
        if targetZone == currentZone {
            backgroundColor = .green
        } else if targetZone <= currentZone + tolerance && targetZone >= currentZone - tolerance {
            backgroundColor = .yellow
        } else {
            backgroundColor = .red
        }
    }
}

#Preview {
    TargetZoneView(targetZone: .constant(2))
        .environmentObject(WorkoutManager())
}
