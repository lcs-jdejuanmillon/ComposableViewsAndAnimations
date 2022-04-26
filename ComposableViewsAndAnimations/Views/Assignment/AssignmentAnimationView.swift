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
        ZStack {
            Circle()
                .trim(from: 0, to: (totalTime - timePassed) / totalTime)
                .stroke(Color.red, lineWidth: 15)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            Text("\(Int(totalTime - timePassed))")
                .font(.title)
        }
        .onTapGesture {
            withAnimation(.linear(duration: totalTime)) {
                timePassed = totalTime
            }
        }
    }
}

struct AssignmentAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentAnimationView(totalTime: 100.0)
    }
}
