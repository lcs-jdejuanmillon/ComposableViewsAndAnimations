//
//  ProjectileView.swift
//  ComposableViewsAndAnimations
//
//  Created by Jacobo de Juan Millon on 2022-04-29.
//

import SwiftUI

struct ProjectileView: View {
    let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    let initialVelocityX: Double
    let initialVelocityY: Double
    let accelerationX: Double
    let accelerationY: Double
    let totalTime: Double
    var scaleFactor: Double {
        return min(400 * (initialVelocityX + totalTime * accelerationX), 300 * (initialVelocityY + totalTime * accelerationY)) / totalTime / (initialVelocityX + totalTime * accelerationX) / (initialVelocityY + totalTime * accelerationY)
    }
    @State var time = 0.0
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ComposableViewsAndAnimations(size: 50.0,
                                             width: 0.2,
                                             fontSize: 0.5,
                                             totalTime: totalTime,
                                             decimalsShown: 0,
                                             showTime: true,
                                             timeFormat: false,
                                             runAutomatically: true)
                
            }
            Circle()
                .frame(width: 50, height: 50)
                .offset(x: scaleFactor * time * (initialVelocityX + time * accelerationX / 2), y: scaleFactor * time * (initialVelocityY + time * accelerationY / 2))
                .onReceive(timer) { input in
                    withAnimation(.linear(duration: 10.0)) {
                        time = totalTime
                    }
                    timer.upstream.connect().cancel()
                }
            Spacer()
        }
        .padding()
    }
}

struct ProjectileView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectileView(initialVelocityX: 5.0,
                       initialVelocityY: 1.0,
                       accelerationX: 0.0,
                       accelerationY: 9.8,
                       totalTime: 5.0)
    }
}
