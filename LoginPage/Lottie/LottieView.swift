//
//  AnimatingView.swift
//  EternalHealth
//
//  Created by Sanjeev Bharti on 4/18/23.
//

import SwiftUI
import Lottie

/// Custom view to show Lottie Animation
public struct LottieView: UIViewRepresentable {
    
    /// Name of the Lottie JSON for rendering
    var name = ""
    /// Animation Repeat type
    var loopMode: LottieLoopMode = .playOnce
    
    // Play/Stop lottie animation
    var isStopped: Bool = false
    
    // Lottie animation view
    private let animationView = LottieAnimationView()
    
    public func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        let animation = LottieAnimation.named(name)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.play { _ in }
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            if isStopped {
                context.coordinator.parent.animationView.stop()
            } else {
                context.coordinator.parent.animationView.play()
            }
        }
    }
    
}

extension LottieView {
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: NSObject {
        var parent: LottieView
        init(_ parent: LottieView) {
            self.parent = parent
        }
    }
}

struct AnimatingView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView()
    }
}
