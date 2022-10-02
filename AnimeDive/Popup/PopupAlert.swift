//
//  PopupAlert.swift
//  AnimeDive
//
//  Created by Robert B on 30/09/2022.
//

import Foundation
import UIKit

class PopupAlert: NSObject{
    
    static let shared = PopupAlert()
    //Show alert
    
    func createAlert(view: UIViewController, title: String, message: MessageErrorType) {
        let alert = UIAlertController(title: title, message: message.message, preferredStyle: .actionSheet)
        alert.isSpringLoaded = true
        alert.view?.layer.cornerRadius = 8
        alert.view.backgroundColor = message.backgroundColor
        // Create custom MessageView
        let customView: UIView = {
            let customView = MessageView()
            customView.backgroundColor = .blue
            customView.messageLabel.text = message.message
            customView.titleLabel.text = title
            return customView
        }()
        
        alert.view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: alert.view.topAnchor),
            customView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor),
            customView.leftAnchor.constraint(equalTo: alert.view.leftAnchor),
            customView.rightAnchor.constraint(equalTo: alert.view.rightAnchor)
        ])
        
        view.present(alert, animated: true)
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) {
            (Timer) in
            view.dismiss(animated: true)
        }
    }
    private override init() {
        
    }
}





