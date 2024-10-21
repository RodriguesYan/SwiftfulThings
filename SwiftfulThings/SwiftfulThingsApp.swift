//
//  SwiftfulThingsApp.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 04/07/24.
//

import SwiftUI

@main
struct SwiftfulThingsApp: App {
    var userIsSignedIn: Bool
    init() {
        userIsSignedIn = CommandLine.arguments.contains("-UITest_StartSignedIn") ? true : false
        
        var myEnv = ProcessInfo.processInfo.environment["UITest_StartSignedIn2"]
    }
    var body: some Scene {
        WindowGroup {
//            MatchedGeometryEffectExample2()
            UITestingBootcampView(currentUserIsSignedIn: userIsSignedIn)
        }
    }
}
