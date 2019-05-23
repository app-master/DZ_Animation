//
//  ViewController.swift
//  DZ_Animation
//
//  Created by user on 22/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var superTestView: UIView!
    
    weak var testView: UIView!
    
    var testViewAnimator: UIViewPropertyAnimator?
    
    var playButtonPressed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let view = UIView(frame: frame)
        view.backgroundColor = .red
        superTestView.addSubview(view)
        testView = view
        
    }
    
    func randomColor() -> UIColor {
        let red = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let green = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let blue = CGFloat(arc4random()) / CGFloat(UInt32.max)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
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
    
    func moveView(_ view: UIView) {
        
        let rect = superTestView.bounds.insetBy(dx: testView.bounds.width, dy: testView.bounds.height)
        
        let randomX = CGFloat(arc4random_uniform(UInt32(rect.width))) + rect.minX
        let randomY = CGFloat(arc4random_uniform(UInt32(rect.height))) + rect.minY
        
        let randomScaleX = CGFloat(arc4random_uniform(UInt32(1.5 * 100)) / 100) + CGFloat(0.5)
        let randomScaleY = CGFloat(arc4random_uniform(UInt32(1.5 * 100)) / 100) + CGFloat(0.5)
        
        let parameter = UICubicTimingParameters(animationCurve: .linear)
        
        let animator = UIViewPropertyAnimator(duration: 3, timingParameters: parameter)
        
        animator.addAnimations {
            self.testView.center = CGPoint(x: randomX, y: randomY)
            self.testView.transform = CGAffineTransform(scaleX: randomScaleX, y: randomScaleY)
            self.testView.backgroundColor = self.randomColor()
        }
        
        animator.addCompletion { _ in
            self.moveView(view)
        }
        
        testViewAnimator = animator
        
        testViewAnimator!.startAnimation()
        
    }
    
    @IBAction func actionBackwardButton(_ sender: UIButton) {
        
        testViewAnimator?.fractionComplete -= 0.2
            
        let animator = animationButtonPressed(button: sender) {
            sender.transform = CGAffineTransform.identity
            sender.superview?.backgroundColor = .clear
        }
        animator.startAnimation()
    }

    @IBAction func actionForwardButton(_ sender: UIButton) {
        
        testViewAnimator?.fractionComplete += 0.2
            
        let animator = animationButtonPressed(button: sender) {
            sender.transform = CGAffineTransform.identity
            sender.superview?.backgroundColor = .clear
        }
        animator.startAnimation()
    }
    
    @IBAction func actionPlayButton(_ sender: UIButton) {
        
        if testViewAnimator == nil {
            moveView(testView)
        } else if !self.playButtonPressed {
            self.testViewAnimator?.pauseAnimation()
        } else {
            let newParameters = UICubicTimingParameters(animationCurve: .linear)
            self.testViewAnimator?.continueAnimation(withTimingParameters: newParameters, durationFactor: 1)
        }
        
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

