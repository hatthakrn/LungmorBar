//
//  dateView.swift
//  testLungmorBar
//
//  Created by xxporsche on 2/4/2566 BE.
//

import SwiftUI

struct DateView: View {
    let weekdays = ["วันจันทร์", "วันอังคาร", "วันพุธ", "วันพฤหัสบดี", "วันศุกร์", "วันเสาร์", "วันอาทิตย์"]
    
    var body: some View {
           
            NavigationView {
                
                List(weekdays, id: \.self) { weekday in
                    NavigationLink(destination: ContentView ()) {
                        Text(weekday)
                    }
                }
                .navigationTitle("")
            }
        
    }
    
    struct DateView_Previews: PreviewProvider {
        static var previews: some View {
            DateView()
        }
    }
}
