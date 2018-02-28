//
//  AnimatedImageView.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/29/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit

enum DisplayMode {
    case before,after,compare
}

class DetailImageView: UIImageView,CAAnimationDelegate{
    
    private let duration = CFTimeInterval(exactly: 4.0)
    
    private var beforeImage: CGImage?
    
    private var afterImage: CGImage?
    
    private var animationSwitch : Bool = true
    
    private var currentMode : DisplayMode = .after
    
    private let indicator : UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    public func loadImage(before:CGImage? = nil,after:CGImage? = nil){
        if let before = before {
            beforeImage = before
        }
        if let after = after {
            afterImage = after
        }
        switchDisplay(mode: currentMode)
    }
    
    public func switchDisplay(mode:DisplayMode){
        currentMode = mode
        switch mode {
        case .before:
            if let loadedImage = beforeImage {
                staticImageLoaded(loadedImage: loadedImage)
            } else {
                imageLoading()
            }
        case .after:
            if let loadedImage = afterImage {
                staticImageLoaded(loadedImage: loadedImage)
            } else {
                imageLoading()
            }
        case .compare:
            configAnimation()
        }
    }
    
    public func refresh() {
        switchDisplay(mode: currentMode)
    }
    
    private func setup(){
        switchDisplay(mode: currentMode)
        self.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: indicator, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: indicator, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
    }
    
    private func imageLoading() {
        image = nil
        indicator.startAnimating()
        isUserInteractionEnabled = false
    }
    
    private func staticImageLoaded(loadedImage:CGImage){
        layer.removeAllAnimations()
        indicator.stopAnimating()
        image = UIImage(cgImage:loadedImage)
        isUserInteractionEnabled = true
    }
    
    private func configAnimation() {
        isUserInteractionEnabled = false
        if let loadedBeforeImage = beforeImage, let loadedAfterImage = afterImage {
            indicator.stopAnimating()
            animationSwitch = true
            image = UIImage(cgImage:loadedAfterImage)
            addAnimation(from: loadedBeforeImage, to: loadedAfterImage)
        } else {
            imageLoading()
        }
    }
   
    private func addAnimation(from:CGImage?,to:CGImage?){
        let crossfade : CABasicAnimation = CABasicAnimation(keyPath: "contents")
        crossfade.duration = duration!
        crossfade.fromValue = from
        crossfade.toValue = to
        crossfade.delegate = self
        layer.add(crossfade, forKey: "animateContents")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        // animation is not completed
        if !flag {
            layer.removeAllAnimations()
            return
        }
        // set image to prevent image flash
        if animationSwitch {
            image = UIImage(cgImage:beforeImage!)
        } else {
            image = UIImage(cgImage:afterImage!)
        }
        animationSwitch = !animationSwitch
        // remove previous animation and add a reverse one
        layer.removeAllAnimations()
        if animationSwitch {
            addAnimation(from: beforeImage, to: afterImage)
        } else {
            addAnimation(from: afterImage, to: beforeImage)
        }
    
    }
}
