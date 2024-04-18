//
//  targetzoneApp.swift
//  targetzone Watch App
//
//  Created by admin on 4/17/24.
//

import SwiftUI

@main
struct targetzone_Watch_AppApp: App {
    @StateObject private var workoutManager = WorkoutManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(workoutManager)
                .onAppear {
                    workoutManager.requestAuthorization()
                }
        }
    }
}
