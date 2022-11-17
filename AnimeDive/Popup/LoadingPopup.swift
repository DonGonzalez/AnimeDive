//
//  LoadingPopup.swift
//  AnimeDive
//
//  Created by Robert B on 19/10/2022.
//

import Foundation
import UIKit

class LoadingPopup: UIView {
    
    static let shared = LoadingPopup()
    
    var popupPresented: ((Int) -> Void)?
    
    func configure() {
        
        self.addSubview(blurEffectView)
        self.addSubview(popupContainer)
        NSLayoutConstraint.activate([
            popupContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            popupContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            popupContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            popupContainer.widthAnchor.constraint(equalTo:self.widthAnchor, multiplier: 0.8)
        ])
        
        popupContainer.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: popupContainer.topAnchor, constant: 30),
            messageLabel.centerXAnchor.constraint(equalTo: popupContainer.centerXAnchor),
            messageLabel.heightAnchor.constraint(equalToConstant: 40),
            messageLabel.widthAnchor.constraint(equalTo: popupContainer.widthAnchor, multiplier: 0.8)
        ])
        
        popupContainer.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 5),
            loadingIndicator.centerXAnchor.constraint(equalTo: popupContainer.centerXAnchor),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 70),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func createLoadingPopup(view: UIViewController, index: Int) -> UIView {
        
        blurEffectView.frame = view.view.bounds
        self.frame = view.view.bounds
        self.isUserInteractionEnabled = true
        self.popupPresented?(index)
        self.configure()
        return self
    }
    
    func dismissLoadingPopup() {
        self.removeFromSuperview()
    }
    
    let blurEffectView: UIView = {
        let blur = UIVisualEffectView()
        blur.alpha = 0.75
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blur.effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        return blur
    }()
    
    let popupContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 15
        container.backgroundColor = .white
        return container
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Please wait ..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        indicator.overrideUserInterfaceStyle = .light
        indicator.style = .large
        indicator.startAnimating()
        return indicator
    }()
}


