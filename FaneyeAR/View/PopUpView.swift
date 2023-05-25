//
//  PopUpView.swift
//  FaneyeAR
//
//  Created by Wita Dewisari Tasya on 22/05/23.
//

import SwiftUI

struct PopUpView: View {
    @Binding var isHelpButtonTapped: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.opacity(0.0001)
                    .onTapGesture {
                        isHelpButtonTapped = false
                    }
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Hello, Concert Enthusiast!")
                        .font(.custom("Chalkboard", fixedSize: 24))
                        .padding()
                    VStack (alignment: .leading) {
                        Text("Faneye will help you choose the most suitable eye makeup for your next concert")
                            .padding()
                        Text("You can swipe to change the filter")
                            .padding()
                        Text("You found the good one? Capture the preview with shutter button on your middle bottom screen! It will put the picture directly to your photos")
                            .padding()
                    }
                }
                .frame(width: geometry.size.width * 0.8,
                       height: geometry.size.height * 0.5)
                .background(VisualEffectView())
                .cornerRadius(20)
                .shadow(radius: 20)
                .padding()
            }
        }
    }
}

struct VisualEffectView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<VisualEffectView>) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<VisualEffectView>) {
    }
}

//struct PopUpView_Previews: PreviewProvider {
//    @Binding var isHelpButtonTapped: Bool
//
//    static var previews: some View {
//        PopUpView()
//    }
//}
