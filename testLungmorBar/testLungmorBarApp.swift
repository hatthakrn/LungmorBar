//
//  testLungmorBarApp.swift
//  testLungmorBar
//
//  Created by xxporsche on 30/3/2566 BE.
//

import SwiftUI
import Firebase

@main
struct testLungmorBarApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            FirstPage()
        }
    }
}
