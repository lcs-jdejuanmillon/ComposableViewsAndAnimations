//
//  AssignmentAnimationView.swift
//  ComposableViewsAndAnimations
//
//  Created by Jacobo de Juan Millon on 2022-04-26.
//

import SwiftUI

struct AssignmentAnimationView: View {
    let totalTime: Double
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timePassed = 0.0
    @State var isTimerRunning = false
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Image(systemName: "pause.circle")
                    .opacity(isTimerRunning ? 1.0 : 0.0)
                Image(systemName: "play.circle")
                    .opacity(isTimerRunning ? 0.0 : 1.0)
            }
            .onTapGesture {
                isTimerRunning = !isTimerRunning
            }
            ZStack {
                Circle()
                    .trim(from: 0, to: (totalTime - timePassed) / totalTime)
                    .stroke(Color.red, lineWidth: 15)
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(-90))
                Text("\(totalTime - timePassed)")
                    .font(.title)
            }
        }
    }
}
struct AssignmentAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentAnimationView(totalTime: 100.0)
    }
}
