//
//  HomeView.swift
//  TabBar
//
//  Created by YILMAZ ER on 22.05.2023.
//

import SwiftUI

struct HomeView: View {
    /// View Properties
    @State private var activateTab: Tab = .home
    /// For Smooth Shape Sliding Effect, We're going to use Matched Geometry Effect
    @Namespace private var animation
    @State private var tabShapePosition: CGPoint = .zero
    
//    init() {
//        /// Hiding Tab Bar Due To SwiftUI IOS 16 BUG
//        UITabBar.appearance().isHidden = true
//    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activateTab) {
                Text("Home")
                    .tag(Tab.home)
//                  .toolbar(.hidden, for: .tabBar)
                
                Text("Services")
                    .tag(Tab.services)
//                    .toolbar(.hidden, for: .tabBar)
                                        
                Text("Partners")
                    .tag(Tab.partners)
//                    .toolbar(.hidden, for: .tabBar)
                
                Text("Activity")
                    .tag(Tab.activity)
//                    .toolbar(.hidden, for: .tabBar)
          }
            CustomTabBar()
        }
    }
    
    /// Custom Tab Bar
    ///  With More Easy Customization
    @ViewBuilder
    func CustomTabBar(_ tint: Color = Color("Blue"), _ inactivateTint: Color = .blue) -> some View {
        /// Moving all the Remaining Tab Item's to Bottom
        HStack(alignment: .bottom,spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) {
                TabItem(tint: tint, inactivateTint: inactivateTint, tab: $0, animation: animation, activateTab: $activateTab, position: $tabShapePosition)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(content: {
            TabShape(midpoint: tabShapePosition.x)
                .fill(Color("Primary"))
                .ignoresSafeArea()
                .shadow(color: Color("Secondary").opacity(0.2), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top, 25)
        })
        /// Adding Animation
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activateTab)
        
    }
}

/// Tab Bar Item
struct TabItem: View {
    var tint: Color
    var inactivateTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activateTab: Tab
    @Binding var position: CGPoint
    
    /// Each Tab Item Position on the Screen
    @State private var tabPosition: CGPoint = .zero
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundColor(activateTab == tab ? .white : inactivateTint)
                /// Increasing Size for the Active Tab
                .frame(width: activateTab == tab ? 58 : 35, height: activateTab == tab ? 58 : 35)
                .background {
                    if activateTab == tab {
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            
            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor(activateTab == tab ? tint : .gray)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition(completion: { rect in
            tabPosition.x = rect.midX
            /// Updating Active Tab Position
            if activateTab == tab {
                position.x = rect.midX
            }
        })
        .onTapGesture {
            activateTab = tab
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                position.x = tabPosition.x
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
