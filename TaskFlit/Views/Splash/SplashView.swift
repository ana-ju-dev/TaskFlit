//
//  SplashView.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import SwiftUI

struct SplashView: View {

    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {

        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image("TaskFlitLogo")
                    .scaledToFit()
            }
        }
        .scaleEffect(size)
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeIn(duration: 1.2)) { //temporizador porque nao tem API e banco de dados
                self.size = 1.0
                self.opacity = 1.0
                }
            }
        }
    }

#Preview {
    SplashView()
}
