//
//  SwiftUiConcurrencyApp.swift
//  SwiftUiConcurrency
//
//  Created by Petru Bocsanean on 24/01/2022.
//

import SwiftUI

@main
struct SwiftUiConcurrencyApp: App {
    @StateObject var courseViewModel = CourseViewModel()
    @StateObject var sectionViewModel = SectionViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(courseViewModel)
                .environmentObject(sectionViewModel)
        }
    }
}
