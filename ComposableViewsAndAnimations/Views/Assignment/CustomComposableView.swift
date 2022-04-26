//
//  CustomComposableView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2021-02-24.
//

import SwiftUI

struct CustomComposableView: View {
    // MARK: Stored properties
    
    @State var xOffset = 0.0
    
    // Rotation amount
    @State var rotationAmount = 0.0
    
    let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    
    // MARK: Computed properties
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 50, height: 50)
            Text("OK")
                .foregroundColor(.white)
        }
        .rotationEffect(.degrees(rotationAmount), anchor: .center)
        .offset(x: xOffset, y: 0)
        .animation(
            Animation
                .easeInOut(duration: 2)
                .repeatForever(autoreverses: true)
        )
        .onReceive(timer) { input in
            // Move the circle and text over to the right
            xOffset = 100.0
            
            // Turn once
            rotationAmount = 360
            
            // Turn off the timer
            timer.upstream.connect().cancel()
        }
    }
}

struct CustomComposableView_Previews: PreviewProvider {
    static var previews: some View {
        CustomComposableView()
    }
}
