//
//  WelcomingTextView.swift
//  FaneyeAR
//
//  Created by Wita Dewisari Tasya on 22/05/23.
//

import SwiftUI

struct WelcomingTextView: View {
    var body: some View {
        ZStack{
            VStack {
                Text("Welcome to Faneye!")
                    .font(.system(size: 36))
                    .foregroundColor(.black)
                    .background(.white)
                    .fontWeight(.bold)
                    .padding()
                Text("We will help you choose the most suitable eye makeup for your next concert!")
                    .multilineTextAlignment(.center)
                    .fontWeight(.semibold)
                    .padding()
                Text("Tap to Continue")
                    .fontWeight(.semibold)
            }
            .padding()
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)

        }
    }
}

struct WelcomingTextView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomingTextView()
    }
}
