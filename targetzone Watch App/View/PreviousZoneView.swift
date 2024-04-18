//
//  PreviousZoneView.swift
//  targetzone Watch App
//
//  Created by admin on 4/17/24.
//

import SwiftUI

struct PreviousZoneView: View {
    @Binding var selectedTab: Int
    @State var selectedZone: Double = 0.0
    @Binding var previousZone: Double
    let setZone: (Double) -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Previous zone")
                .font(.system(size: 20, weight: .bold))
            
            Picker("", selection: $selectedZone) {
                Text(String(format: "%.0f", previousZone))
                    .font(.system(size: 60, weight: .bold))
                
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 80)
            .onTapGesture {
                // Handle tap gesture
                selectedTab = 0
                setZone(previousZone)
            }
            Spacer()
        }
    }
}

#Preview {
    PreviousZoneView(selectedTab: .constant(0), previousZone: .constant(2.0)) { _ in
    }
}
