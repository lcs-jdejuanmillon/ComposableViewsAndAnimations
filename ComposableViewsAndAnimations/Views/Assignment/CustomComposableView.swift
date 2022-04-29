//
//  ComposableViewsAndAnimations.swift
//  ComposableViewsAndAnimations
//
//  Created by Jacobo de Juan Millon on 2022-04-26.
//

import SwiftUI

struct ComposableViewsAndAnimations: View {
    let size: Double
    let totalTime: Double
    var decimalsShown: Int
    var showTime: Bool
    var timeFormat: Bool
    let runAutomatically: Bool
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var timePassed = 0.0
    @State var isTimerRunning = false
    @State var timePassedNoAnimation = 0.0
    var timeLeftNoAnimation: Double {
        return totalTime - timePassedNoAnimation
    }
    var time: String {
        if !timeFormat {
            return String(format: "%.\(decimalsShown)f", timeLeftNoAnimation)
        }
        let seconds = format(time: timeLeftNoAnimation, limit: 60, isSeconds: true)
        if timeLeftNoAnimation < 60 {
            return seconds
        }
        let minutes = format(time: Double(Int(timeLeftNoAnimation) / 60), limit: 60, isSeconds: false)
        if timeLeftNoAnimation < 3600 {
            return "\(minutes):\(seconds)"
        }
        let hours = format(time: Double(Int(timeLeftNoAnimation) / 3600), limit: 24, isSeconds: false)
        if timeLeftNoAnimation < 86400 {
            return "\(hours):\(minutes):\(seconds)"
        }
        return "\(Int(timeLeftNoAnimation)/86400):\(hours):\(minutes):\(seconds)"
    }
    var body: some View {
        VStack() {
            ZStack {
                Circle()
                    .trim(from: 0, to: (totalTime - timePassed) / totalTime)
                    .stroke(Color(hue: (totalTime - timePassed) / totalTime / 3,
                                  saturation: 1.0,
                                  brightness: 1.0),
                            lineWidth: size / 10)
                    .frame(width: size, height: size)
                    .rotationEffect(.degrees(-90))
                    .onReceive(timer) { input in
                        if runAutomatically {
                            if timeLeftNoAnimation > 0.01 {
                                withAnimation(.linear) {
                                    timePassed += 0.01
                                }
                                timePassedNoAnimation += 0.01
                            }
                            else {
                                timer.upstream.connect().cancel()
                            }
                        }
                        else {
                            if isTimerRunning {
                                if timeLeftNoAnimation > 0.01 {
                                    withAnimation(.linear(duration: 0.01)) {
                                        timePassed += 0.01
                                    }
                                    timePassedNoAnimation += 0.01
                                }
                                else {
                                    timePassedNoAnimation = 0.0
                                    timePassed = 0.0
                                    isTimerRunning = false
                                }
                            }
                        }
                    }
                Text(time)
                    .opacity(showTime ? 1.0 : 0.0)
                    .font(.custom("sf", size: size / 6))
            }
            .opacity(runAutomatically && timeLeftNoAnimation == 0 ? 0.0 : 1.0)
            Spacer()
            HStack {
                Image(systemName: "stop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size / 4, height: size / 4)
                    .onTapGesture {
                        timePassedNoAnimation = 0.0
                        timePassed = 0.0
                        isTimerRunning = false
                    }
                Spacer()
                Image(systemName: (isTimerRunning ? "pause.circle" : "play.circle"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: size / 4, height: size / 4)
                    .onTapGesture {
                        isTimerRunning = !isTimerRunning
                    }
            }
            .opacity(runAutomatically ? 0.0 : 1.0)
        }
        .frame(width: size, height: size * 1.35)
    }
    func format(time: Double, limit: Int, isSeconds: Bool) -> String {
        let t = time - Double(Int(time) / limit * limit)
        let string = String(format: "%.\(isSeconds ? decimalsShown : 0)f", t)
        if round(t * (pow(10.0, Double(decimalsShown)))) < pow(10.0, Double(decimalsShown + 1)) {
            return "0\(string)"
        }
        return string
    }
}
struct ComposableViewsAndAnimations_Previews: PreviewProvider {
    static var previews: some View {
        ComposableViewsAndAnimations(size: 200.0,
                                     totalTime: 100.0,
                                     decimalsShown: 2,
                                     showTime: true,
                                     timeFormat: true,
                                     runAutomatically: false)
    }
}
