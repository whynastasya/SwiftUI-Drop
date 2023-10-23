//
//  ContentView.swift
//  Drop
//
//  Created by nastasya on 23.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var offset: CGSize = .zero
    
    private var initialX: Double {
        UIScreen.main.bounds.width / 2.0
    }
    
    private var initialY: Double {
        UIScreen.main.bounds.height / 2.0
    }
    
    private var point: CGPoint {
        CGPoint(x: initialX, y: initialY)
    }
    
    var body: some View {
        Canvas { context, size in
            let circleOne = context.resolveSymbol(id: 1)!
            let circleTwo = context.resolveSymbol(id: 2)!
            
            context.addFilter(.alphaThreshold(min: 0.5, color: .white))
            context.addFilter(.blur(radius: 15))
            
            context.drawLayer { ctx in
                ctx.draw(circleOne, at: point)
                ctx.draw(circleTwo, at: point)
            }
            
        } symbols: {
            Circle()
                .frame(width: 150, height: 150)
                .tag(1)
            Circle()
                .frame(width: 150, height: 150)
                .offset(x: offset.width, y: offset.height)
                .tag(2)
        }
        .gesture(
            DragGesture()
                .onChanged {
                    offset = $0.translation
                }
                .onEnded { _ in
                    withAnimation(.spring(.snappy(duration: 1, extraBounce: 0.5))) {
                        offset = .zero
                    }
                })
        .ignoresSafeArea()
        .background(.purple)
    }
}

#Preview {
    ContentView()
}
