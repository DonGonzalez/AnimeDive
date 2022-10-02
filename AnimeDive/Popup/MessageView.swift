//
//  MessageView.swift
//  AnimeDive
//
//  Created by Robert B on 22/09/2022.
//

import Foundation
import UIKit

class MessageView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.isHighlighted = true
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 1
        titleLabel.text = "Message:"
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    let messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = .systemFont(ofSize: 15)
        messageLabel.isHighlighted = false
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.baselineAdjustment = .alignCenters
        return messageLabel
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.cornerRadius = 8
        stackView.spacing = 1
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(messageLabel)
        return stackView
    }()
   
    func configure() {
        self.layer.cornerRadius = 8
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}
    // animation part
    // I want this save, as a example.
    /*
    @objc func delay() {
        self.animationOut()
    }
    func animationIn() {
        print("animation begin")
        self.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveLinear, animations: {
            self.transform = .identity
        })
        {(startDelay) in
            if startDelay {
                self.perform(#selector(self.delay), with: nil, afterDelay: 3)
            }
        }
    }
    func animationOut() {
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveLinear, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
        }) { (complite) in
            if complite {
                print("complite")
                self.removeFromSuperview()
            }
        }
    }
     */



