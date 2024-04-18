//
//  ConfigZoneView.swift
//  targetzone Watch App
//
//  Created by admin on 4/17/24.
//

import SwiftUI

struct ConfigZoneView: View {
    @Binding var selectedTab: Int
    @Binding var targetZone: Double
    @State var selectedZone: Double = 0.0
    let zoneOptions: [Double] = Array(stride(from: 1.0, through: 5.0, by: 1))
    let setZone: (Double) -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Configure zone")
                .font(.system(size: 20, weight: .bold))
            
            Picker("", selection: $selectedZone) {
                ForEach(zoneOptions, id: \.self) { zone in
                    Text(String(format: "%.0f", zone))
                        .font(.system(size: zone == self.selectedZone ? 60: 20, weight: .bold))
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 80)
            .onTapGesture {
                // Handle tap gesture
                selectedTab = 0
                setZone(selectedZone)
            }
            Spacer()
        }
        .onAppear() {
            selectedZone = targetZone
        }
    }
}

#Preview {
    ConfigZoneView(selectedTab: .constant(0), targetZone: .constant(5.0)) { _ in
    }
}
