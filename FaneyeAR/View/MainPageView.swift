//
//  MainPageView.swift
//  FaneyeAR
//
//  Created by Wita Dewisari Tasya on 22/05/23.
//

import SwiftUI
import AVFoundation

struct MainPageView: View {
    @State private var isCameraAuthorized = false //Checking Camera Authorization
    @State private var isOverlayVisible = true // Overlay Welcoming Page
    @State private var isShowingPage = true // Splash Screen Variable
    
    var body: some View {
        ZStack {
            if isShowingPage {
                //Call Splash Screen
                SplashScreenView()
            } else {
                // Call Main Page
                ZStack{
                    if isOverlayVisible {
                        WelcomingTextView()
                            .onTapGesture {
                                hideOverlay()
                            }
                    }
                    //Main page after overlay gone
                    if !isOverlayVisible{
                        ContentView()
                    }
                }
                
            }
        }
        .onAppear {
            startTimer() //Timer Splash Screen
        }
    }
    
    //Functions
    
    // Timer Splash Screen
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
            isShowingPage = false
        }
    }
    
    // Overlay Welcoming Text
    private func hideOverlay() {
        isOverlayVisible = false
    }
    
    // Camera Authorizzation Status
    private func checkCameraAuthorizationStatus() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        isCameraAuthorized = (status == .authorized)
    }
    
    // Camera Permission
    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                isCameraAuthorized = granted
            }
        }
    }
}



struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
