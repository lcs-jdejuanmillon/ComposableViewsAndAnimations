//
//  KinematicsChoosingView.swift
//  ComposableViewsAndAnimations
//
//  Created by Jacobo de Juan Millon on 2022-04-29.
//

import SwiftUI

struct KinematicsChoosingView: View {
    @State private var inputTime: String = ""
    @State private var inputInitialVelocityX: String = ""
    @State private var inputInitialVelocityY: String = ""
    @State private var inputAccelerationX: String = ""
    @State private var inputAccelerationY: String = ""
    var time: Double {
        if let time = Double(inputTime) {
            if time > 0.05 {
                return time
            }
        }
        return -1.0
    }
    var body: some View {
        VStack(alignment: .leading) {
            
            Group {
                TextField("Time in Seconds", text: $inputTime)
                    .foregroundColor(time > 0 ? .red : .primary)
                TextField("Initial Horizontal Velocity in m/s", text: $inputInitialVelocityX)
                    .foregroundColor(validInput(input: inputInitialVelocityX) ? .red : .primary)
                TextField("Initial Vertical Velocity in m/s", text: $inputInitialVelocityY)
                    .foregroundColor(validInput(input: inputInitialVelocityY) ? .red : .primary)
                TextField("Horizontal Acceleration in m/s2", text: $inputAccelerationX)
                    .foregroundColor(validInput(input: inputAccelerationX) ? .red : .primary)
                TextField("Vertical Acceleration in m/s2", text: $inputAccelerationY)
                    .foregroundColor(validInput(input: inputAccelerationY) ? .red : .primary)
            }
            .padding(.bottom)
            
            List {
                NavigationLink(destination: ProjectileView(initialVelocity: [4.0, 1.0],
                                                           acceleration: [2.0, -10.0],
                                                           totalTime: Double(inputTime)!)) {
                    SimpleListItemView(title: "Kinematics Animation",
                                       caption: "Movement of an object in two dimensions with constant acceleration")
                }
            }
            .opacity(time > 0 && validInput(input: inputInitialVelocityX) && validInput(input: inputInitialVelocityX) && validInput(input: inputAccelerationX) && validInput(input: inputAccelerationY) ? 0.0 : 1.0)
            
        }
        .padding()
        .navigationTitle("My Composable View")
    }
    func validInput(input: String) -> Bool {
        if let _ = Double(input) {
            return true
        }
        return false
    }
}

struct KinematicsChoosingView_Previews: PreviewProvider {
    static var previews: some View {
        KinematicsChoosingView()
    }
}
