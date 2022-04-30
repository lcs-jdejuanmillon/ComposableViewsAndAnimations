//
//  OneDimensionView.swift
//  ComposableViewsAndAnimations
//
//  Created by Jacobo de Juan Millon on 2022-04-29.
//

import SwiftUI

struct OneDimensionView: View {
    let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    let initialVelocity: Double
    let acceleration: Double
    let totalTime: Double
    var scaleFactor: Double {
        return 400 / totalTime / (initialVelocity + totalTime * acceleration)
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
                .offset(x: 0, y: scaleFactor * time * (initialVelocity + time * acceleration / 2))
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

struct OneDimensionView_Previews: PreviewProvider {
    static var previews: some View {
        OneDimensionView(initialVelocity: 4.0,
                         acceleration: 2.5,
                         totalTime: 10.0)
    }
}

