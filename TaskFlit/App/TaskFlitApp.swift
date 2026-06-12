//
//  TaskFlitApp.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import SwiftUI

@main
struct TaskFlitApp: App {
    @State private var showSplash: Bool = true //vigiando o valor da variavel
    
    var body: some Scene {
        WindowGroup {
            if showSplash { //true
                SplashView()
                
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation(.easeOut(duration: 0.5)) {
                                showSplash = false
                            }
                        }
                    }
            } else { //false
                MainTabView()
            }
        }
    }
}
