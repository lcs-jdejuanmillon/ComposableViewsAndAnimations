//
//  IAExampleTwoView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2021-02-23.
//
 
import SwiftUI
 
struct IAExampleTwoView: View {
    
    // MARK: Stored properties
    
    // Controls whether this view is showing or not
    @Binding var showThisView: Bool
    
    // Controls the size of the circle
    @State private var scaleFactor: CGFloat = 1.0
 
    // Controls the hue of the circle
    @State private var hue: Color = .red
    
    // Whether to apply the animation
    @State private var useAnimation = true
    
    // MARK: Computed properties
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Circle()
                    .foregroundColor(hue)
                    .scaleEffect(scaleFactor)
                    .onTapGesture {
                        if scaleFactor > 0.2 {
                            // Reduce the size of the circle by a tenth
                            scaleFactor -= 0.1
                        } else {
                            // Make sure the button doesn't entirely disappear
                            scaleFactor = 1
                            // Change the color of the view to a random hue
                            hue = Color(hue: Double.random(in: 1...360) / 360.0,
                                        saturation: 0.8,
                                        brightness: 0.8)
                        }
                    }
                    // This is an implicit animation.
                    // The changes in state (scaleFactor AND hue) are animated since the .animation view
                    // modifier is listed AFTER the view modifier where the scaleFactor and hue are changed.
                    //
                    // NOTE: A ternary conditional operator is used to control whether the state
                    // change is animated or not.
                    // When useAnimation is true, the linear animation effect with a duration of 2.5 seconds will be used.
                    // When useAnimation is false, there will be no animation.
                    .animation(useAnimation ? .linear(duration: 2.5) : .none)
                
                Spacer()
                
                // To control whether state changes are animated
                Toggle("Animate state change", isOn: $useAnimation)
                    .padding()
 
                Text("To see the animation, remember to remove the comment on line 57 of **IAExampleTwoView.swift** ☺️")
                    .font(.caption)
                    .padding()
                
            }
            .navigationTitle("Example 2")
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
 
struct IAExampleTwoView_Previews: PreviewProvider {
    static var previews: some View {
        IAExampleTwoView(showThisView: .constant(true))
    }
}
