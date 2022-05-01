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
        return min(500 * displacement(time: totalTime, isVertical: false), 300 * displacement(time: totalTime, isVertical: true)) / displacement(time: totalTime, isVertical: false) / displacement(time: totalTime, isVertical: true)
    }
    @State var time = 0.0
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 50, height: 50)
                    .offset(x: scaleFactor * displacement(time: time, isVertical: false), y: scaleFactor * displacement(time: time, isVertical: true))
                    .onReceive(timer) { input in
                        withAnimation(.linear(duration: totalTime)) {
                            time = totalTime
                        }
                        timer.upstream.connect().cancel()
                    }
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
            Spacer()
        }
        .padding()
    }
    func displacement(time: Double, isVertical: Bool) -> Double {
        if isVertical {
            return time * (initialVelocityY + time * accelerationY / 2)
        }
        return time * (initialVelocityX + time * accelerationX / 2)
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
