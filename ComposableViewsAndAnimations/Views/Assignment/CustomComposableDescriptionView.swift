//
//  CustomComposableDescriptionView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2021-02-23.
//

import SwiftUI

struct CustomComposableDescriptionView: View {
    
    // MARK: Stored properties
    @State private var phrase: String = ""
    @State var decimalsShown = 1.0
    @State var e = 1.0
    // MARK: Computed properties
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Group {
                
                Text("Description")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                Text("""
                    The view is a circular clock that continously drains as time passes and shows how much time is left until it finished. The clock can be paused/continued and stopped with the buttons in the view. The number of decimals shown and the time for the clock can be changed below.
                    """)
                
                TextField("Time in Seconds", text: $phrase)
                Text("Number of Decimals Shown")
                Slider(value: $decimalsShown,
                       in: 0...2,
                       step: 1.0,
                       label: {
                    Text("Number of decimals Shown")
                }, minimumValueLabel: {
                    Text("0")
                }, maximumValueLabel: {
                    Text("2")
                })
            }
            .padding(.bottom)
            
            List {
                NavigationLink(destination: AssignmentAnimationView(totalTime: 15.0, decimalsShown: decimalsShown)) {
                    SimpleListItemView(title: "My Composable View",
                                       caption: "A brief description of my view")
                }
            }
            
        }
        .padding()
        .navigationTitle("My Composable View")
        
    }
}

struct CustomComposableDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CustomComposableDescriptionView()
        }
    }
}
