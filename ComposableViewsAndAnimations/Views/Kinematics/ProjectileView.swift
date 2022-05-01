//
//  ProjectileView.swift
//  ComposableViewsAndAnimations
//
//  Created by Jacobo de Juan Millon on 2022-04-29.
//
// X = 0, Y = 1
import SwiftUI

struct ProjectileView: View {
    let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    let initialVelocity: [Double]
    let acceleration: [Double]
    let totalTime: Double
    var vertexX: Double {
        if initialVelocity[0] * (initialVelocity[0] + totalTime * acceleration[0]) > 0 {
            return 0.0
        }
        return -initialVelocity[0] / acceleration[0]
    }
    var minX: Double {
        return min(displacement(time: totalTime, dimension: 0), min(0, displacement(time: vertexX, dimension: 0)))
    }
    var maxX: Double {
        return max(displacement(time: totalTime, dimension: 0), max(0, displacement(time: vertexX, dimension: 0)))
    }
    var scaleFactor: Double {
        return min(500 * displacement(time: totalTime, dimension: 0), 300 * displacement(time: totalTime, dimension: 1)) / displacement(time: totalTime, dimension: 0) / displacement(time: totalTime, dimension: 1)
    }
    @State var time = 0.0
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 50, height: 50)
                    .offset(x: scaleFactor * displacement(time: time, dimension: 0), y: scaleFactor * displacement(time: time, dimension: 1))
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
    func displacement(time: Double, dimension: Int) -> Double {
        return time * (initialVelocity[dimension] + time * acceleration[dimension] / 2)
    }
}
struct ProjectileView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectileView(initialVelocity: [5.0, 1.0],
                       acceleration: [0.0, 9.8],
                       totalTime: 5.0)
    }
}
