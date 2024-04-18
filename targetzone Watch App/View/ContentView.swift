//
//  ContentView.swift
//  targetzone Watch App
//
//  Created by admin on 4/17/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var selectedTab = 0
    @AppStorage("targetZone") var targetZone: Double = -1.0
    @State private var previousZones: [Double] = []
    
    // Function to set both target zone and previous zone
    func setZone(newZone: Double) {
        if previousZones.contains(targetZone) == false && targetZone > 0 {
            previousZones.append(targetZone)
            if previousZones.count == 6 {
                previousZones.removeFirst();
            }
        }
        targetZone = newZone
        print(newZone)
    }
    
    var body: some View {
        VStack {
            if workoutManager.authorizationGranted {
                TabView(selection: $selectedTab) {
                    if targetZone > 0 {
                        TargetZoneView(targetZone: $targetZone)
                            .environmentObject(workoutManager)
                            .tag(0)
                    }
                    ConfigZoneView(selectedTab: $selectedTab, targetZone: $targetZone, setZone: setZone)
                        .background(.blue)
                        .tag(1)
                    ForEach(previousZones.indices.reversed(), id: \.self) { index in
                        PreviousZoneView(selectedTab: $selectedTab, previousZone: $previousZones[index], setZone: setZone)
                            .background(.gray)
                            .tag(index + 2)
                    }
                }
            } else {
                VStack(alignment: .leading){
                    Text("⚠️ Oops! It seems some required permissions are not enabled for this app. Go to the 'Settings' app to grant access and unlock all features.")
                    
                    Spacer()
                    Button {
                        workoutManager.checkAuthorizationStatus()
                    } label: {
                        Text("Check Granted")
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(WorkoutManager())
}
