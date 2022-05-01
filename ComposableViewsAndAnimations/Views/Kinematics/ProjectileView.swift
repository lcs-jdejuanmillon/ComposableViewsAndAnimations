//
//  ProjectileView.swift
//  ComposableViewsAndAnimations
//
//  Created by Jacobo de Juan Millon on 2022-04-29.
//
// X = 0, Y = 1
import SwiftUI

struct ProjectileView: View {
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
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
                Spacer()
                ZStack {
                Circle()
                    .trim(from: 0, to: (totalTime - time) / totalTime)
                    .stroke(Color(hue: (totalTime - time) / totalTime / 3,
                                  saturation: 1.0,
                                  brightness: 1.0),
                            lineWidth: 10.0)
                    .frame(width: 50.0, height: 50.0)
                    .rotationEffect(.degrees(-90))
                    .onReceive(timer) { input in
                        time += 0.01
                        if time > totalTime - 0.01 {
                            timer.upstream.connect().cancel()
                        }
                    }
                    Text("\(Int(totalTime - time))")
                        .font(.custom("sf", size: 25.0))
                }
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
        ProjectileView(initialVelocity: [4.0, 1.0],
                       acceleration: [2.0, 10.0],
                       totalTime: 10.0)
    }
}
