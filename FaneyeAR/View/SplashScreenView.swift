//
//  Loading Screen.swift
//  FaneyeAR
//
//  Created by Wita Dewisari Tasya on 22/05/23.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        VStack{
            Image("Logo Faneye")
                .resizable()
                .scaledToFit()
                .frame(width: 400)
            Text("Faneye")
                .padding()
            Text("Through the fan's eyes")
        }
    }
}

struct SplashScreenViewPreviews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
