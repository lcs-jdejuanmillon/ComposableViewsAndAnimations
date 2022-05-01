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
    @State var off = 0.0
    @State var time = 0.0
    var vertex: [Double] {
        var vertex = [0.0, 0.0]
        for i in 0...1 {
            if initialVelocity[i] * (initialVelocity[i] + totalTime * acceleration[i]) <= 0 {
                vertex[i] = -initialVelocity[i] / acceleration[i]
            }
        }
        return vertex
    }
    var minDis: [Double] {
        var minDis = [0.0, 0.0]
        for i in 0...1 {
            minDis[i] = min(0.0, min(displacement(time: totalTime, dimension: i), displacement(time: vertex[i], dimension: i)))
        }
        return minDis
    }
    var maxDis: [Double] {
        var maxDis = [0.0, 0.0]
        for i in 0...1 {
            maxDis[i] = max(0.0, max(displacement(time: totalTime, dimension: i), displacement(time: vertex[i], dimension: i)))
        }
        return maxDis
    }
    var scaleFactor: Double {
        if 500 * (maxDis[0] - minDis[0]) < 300 * (maxDis[1] - minDis[1]) {
            return 500 / (maxDis[1] - minDis[1])
        }
        return 300 * (maxDis[0] - minDis[0])
    }
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
        ProjectileView(initialVelocity: [0.0, 0.0],
                       acceleration: [0.0, 10.0],
                       totalTime: 2.0)
    }
}
