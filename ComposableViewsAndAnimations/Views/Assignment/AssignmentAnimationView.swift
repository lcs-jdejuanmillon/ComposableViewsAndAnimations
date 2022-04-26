//
//  AssignmentAnimationView.swift
//  ComposableViewsAndAnimations
//
//  Created by Jacobo de Juan Millon on 2022-04-26.
//

import SwiftUI

struct AssignmentAnimationView: View {
    let totalTime: Double
    @State var timePassed = 0.0
    var body: some View {
        VStack {
            Circle()
                .trim(from: 0, to: totalTime - timePassed)
                .stroke(Color.red, lineWidth: 15)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
                .padding()
            Button(action: {
                timePassed = totalTime
            },
                   label: {
                Text("Start Timer")
            })
            .padding()
        }
    }
}

struct AssignmentAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentAnimationView(totalTime: 100.0)
    }
}
