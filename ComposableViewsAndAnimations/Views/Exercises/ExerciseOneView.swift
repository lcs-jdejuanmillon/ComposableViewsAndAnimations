//
//  ExerciseOneView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2021-02-23.
//

import SwiftUI
import UIKit

struct ExerciseOneView: View {
   
   // MARK: Stored properties
   
   // Controls whether this view is showing or not
   @Binding var showThisView: Bool
       
   // Whether to apply the animation
   @State private var useAnimation = false
   
   @State var scaleFactor = 1.0
   
   @State var hue = 1.0
   
   @State var y = 0.0
   
   // MARK: Computed properties

   var body: some View {
       
       NavigationView {
           
           VStack {

               Circle()
                   .offset(x: 0.0, y: y)
                   .foregroundColor(Color(hue: hue,
                                          saturation: 0.9,
                                          brightness: 0.8))
                   .scaleEffect(scaleFactor)
                   .frame(width: 200, height: 200)
                   .onTapGesture {
                       if scaleFactor > 0.2 {
                           scaleFactor -= 0.1
                       }
                       else {
                           scaleFactor = 1.0
                       }
                       if hue > 0.1 {
                           hue -= 0.1
                       }
                       else {
                           hue = 1.0
                       }
                       y = Double.random(in: -200.0...200.0)
                   }
                   .animation(.default)
           }
           .navigationTitle("Exercise 1")
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

struct ExerciseOneView_Previews: PreviewProvider {
   static var previews: some View {
       ExerciseOneView(showThisView: .constant(true))
   }
}
