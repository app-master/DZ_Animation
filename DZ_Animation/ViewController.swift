//
//  ViewController.swift
//  DZ_Animation
//
//  Created by user on 22/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var playButtonPressed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func animationButtonPressed(button: UIButton, completion:@escaping () -> ()) -> UIViewPropertyAnimator {
        let parameter = UICubicTimingParameters(animationCurve: .linear)
        let animator = UIViewPropertyAnimator(duration: 0.3, timingParameters: parameter)
        
        animator.addAnimations {
            button.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            button.superview?.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        }
        
        animator.addCompletion { _ in
            completion()
        }
        
        return animator
    }
    
    @IBAction func actionBackwardButton(_ sender: UIButton) {
        let animator = animationButtonPressed(button: sender) {
            sender.transform = CGAffineTransform.identity
            sender.superview?.backgroundColor = .clear
        }
        animator.startAnimation()
    }

    @IBAction func actionForwardButton(_ sender: UIButton) {
        let animator = animationButtonPressed(button: sender) {
            sender.transform = CGAffineTransform.identity
            sender.superview?.backgroundColor = .clear
        }
        animator.startAnimation()
    }
    
    @IBAction func actionPlayButton(_ sender: UIButton) {
        let animator = animationButtonPressed(button: sender) {
            if self.playButtonPressed {
               sender.setImage(UIImage(named: "pause"), for: [])
            } else {
               sender.setImage(UIImage(named: "play"), for: [])
            }
            sender.transform = CGAffineTransform.identity
            sender.superview?.backgroundColor = .clear
            
            self.playButtonPressed.toggle()
        }
        animator.startAnimation()
    }
    
}

