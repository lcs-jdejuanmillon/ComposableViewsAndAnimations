//
//  OneDimensionView.swift
//  ComposableViewsAndAnimations
//
//  Created by Jacobo de Juan Millon on 2022-04-29.
//
 
import SwiftUI
 
struct OneDimensionView: View {
    let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    let initialVelocity = 10.0
    let acceleration = 1.0
    let totalTime = 10.0
    @State var time = 0.0
    var body: some View {
        VStack {
            HStack {
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
            .offset(x: 0, y: time * (initialVelocity + time * acceleration / 2))
            .onReceive(timer) { input in
                withAnimation(.linear(duration: 10.0)) {
                    time = totalTime
                }
                timer.upstream.connect().cancel()
            }
        Spacer()
        }
    }
}
 
struct OneDimensionView_Previews: PreviewProvider {
    static var previews: some View {
        OneDimensionView()
    }
}

