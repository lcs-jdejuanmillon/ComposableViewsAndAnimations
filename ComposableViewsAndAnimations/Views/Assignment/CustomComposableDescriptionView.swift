//
//  CustomComposableDescriptionView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2021-02-23.
//

import SwiftUI

struct CustomComposableDescriptionView: View {
    
    // MARK: Stored properties
    @State private var inputTime: String = ""
    @State var decimalsShown = 1.0
    @State var showTime = true
    @State var timeFormat = false
    @State var runAutomatically = false
    var time: Double {
        if let time = Double(inputTime) {
            if time > 0.05 {
                return time
            }
        }
        return -1.0
    }
    
    // MARK: Computed properties
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Group {
                
                Text("Description")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                Text("""
                    The view is a circular clock that drains and shows how much time is left. It can be paused/continued and stopped with the buttons in the view. The number of decimals shown, the total time, and more can be changed below.
                    """)
                
                TextField("Time in Seconds", text: $inputTime)
                    .foregroundColor(time == -1 ? .red : .primary)
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
                Toggle(isOn: $showTime, label: {Text("Show Time Left")})
                Toggle(isOn: $timeFormat, label: {Text("Show Hours Minutes Seconds")})
                Toggle(isOn: $runAutomatically, label: {Text("Run Automatically")})
            }
            .padding(.bottom)
            
            List {
                NavigationLink(destination: ComposableViewsAndAnimations(size: 200.0,
                                                                         width: 0.1,
                                                                         fontSize: 0.15,
                                                                         totalTime: time,
                                                                         decimalsShown: Int(decimalsShown),
                                                                         showTime: showTime,
                                                                         timeFormat: timeFormat,
                                                                        runAutomatically: runAutomatically)) {
                    SimpleListItemView(title: "Simple timer",
                                       caption: "Shows how many seconds are left")
                }
            }
            .opacity(time == -1 ? 0.0 : 1.0)
            
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
