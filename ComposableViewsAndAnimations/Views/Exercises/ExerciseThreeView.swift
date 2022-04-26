//
//  ExerciseThreeView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2021-02-23.
//

import SwiftUI
import UIKit

struct ExerciseThreeView: View {
    
    // MARK: Stored properties
    
    // Controls whether this view is showing or not
    @Binding var showThisView: Bool
        
    // Controls what typeface the text is shown in
    @State private var typeFace: String = "Helvetica-Neue"

    // Whether to apply the animation
    @State private var useAnimation = false
    
    // How much to rotate the text
    @State private var rotationAmount = 0.0

    @State var size = 30.0
    
    @State var x = 0.0
    
    @State var y = 0.0
    
    @State var scaleFactor = 1.0
    
    @State var hue = 1.0
    // MARK: Computed properties

    // List all fonts available
    // NOTE: This is a very useful gist...
    //       https://gist.github.com/kristopherjohnson/c825cb97b1ad1fe0bc13d709986d0763
    private static let fontNames: [String] = {
        var names: [String] = []
        for familyName in UIFont.familyNames {
            names.append(contentsOf: UIFont.fontNames(forFamilyName: familyName))
        }
        return names.sorted()
    }()

    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                // NOTE: Here are some neat examples to consider...
                //       https://medium.com/better-programming/create-an-awesome-loading-state-using-swiftui-9815ff6abb80
                //
                // NOTE: You might be wondering, in what ways can a view be manipulated?
                //       In other words, what state changes might be fun to animate?
                //       To see options, scroll down to the "Transforming views" section of the web page given here...
                //
                // https://www.hackingwithswift.com/quick-start/swiftui
                Circle()
                    .foregroundColor(Color(hue: hue,
                                           saturation: 0.9,
                                           brightness: 0.8))
                                        .frame(width: 200, height: 200)
                                        .rotation3DEffect(.degrees(rotationAmount), axis: (x: 0,
                                                                                           y: 1,
                                                                                           z: 0))
                Text(typeFace)
                    .font(.custom(typeFace, size: 30.0))
                    .rotation3DEffect(.degrees(rotationAmount), axis: (x: 0,
                                                                       y: 1,
                                                                       z: 0))
                    .padding()
            }
            .scaleEffect(scaleFactor)
            .offset(x: x, y: y)
            .onTapGesture {
                withAnimation(.default.speed(0.25)) {
                    scaleFactor = Double.random(in: 0.3...1.3)
                    hue = Double.random(in: 0.0...1.0)
                    x = Double.random(in: -100.0...100.0)
                    y = Double.random(in: -200.0...200.0)
                }
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                    rotationAmount += 360.0
                }
            }
            
            .navigationTitle("Exercise 3")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Done") {
                        hideView()
                    }
                }
            }

        }
        
    }
    
    // MARK: Functions
    
    // Makes this view go away
    func hideView() {
        showThisView = false
    }
    
}

struct ExerciseThreeView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseThreeView(showThisView: .constant(true))
    }
}

//
