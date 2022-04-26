//
//  IAExampleOneView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2021-02-23.
//
 
import SwiftUI
 
struct IAExampleOneView: View {
    
    // MARK: Stored properties
    
    // Controls whether this view is showing or not
    @Binding var showThisView: Bool
    
    // Controls the size of the circle
    @State private var scaleFactor: CGFloat = 1.0
        
    // Whether to apply the animation
    @State private var useAnimation = true
    
    // MARK: Computed properties
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Circle()
                    .foregroundColor(.red)
                    .scaleEffect(scaleFactor)
                    .onTapGesture {
                        if scaleFactor > 0.2 {
                            // Reduce the size of the circle by a tenth
                            scaleFactor -= 0.1
                        } else {
                            // Make sure the button doesn't entirely disappear
                            scaleFactor = 1
                        }
                    }
                    // This is an implicit animation.
                    // The change in state (scaleFactor) is animated since the .animation view
                    // modifier is listed AFTER the view modifier where scaleFactor is changed.
                    //
                    // NOTE: A ternary conditional operator is used to control whether the state
                    // change is animated or not.
                    // When useAnimation is true, the default animation effect will be used.
                    // When useAnimation is false, there will be no animation.
                    .animation(useAnimation ? .default : .none)
                
                Spacer()
                
                // To control whether state changes are animated
                Toggle("Animate state change", isOn: $useAnimation)
                    .padding()
                
                Text("To see the animation, remember to remove the comment on line 50 of **IAExampleOneView.swift** ☺️")
                    .font(.caption)
                    .padding()
 
            }
            .navigationTitle("Example 1")
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
    
   struct IAExampleOneView_Previews: PreviewProvider {
       static var previews: some View {
           IAExampleOneView(showThisView: .constant(true))
       }
   }
