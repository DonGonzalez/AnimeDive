//
//  PopupAlert.swift
//  AnimeDive
//
//  Created by Robert B on 30/09/2022.
//

import Foundation
import UIKit

class PopupAlert: NSObject {
    
    static let shared = PopupAlert()
    //Show alert
    func createAlert(view: UIViewController, title: String, errorData: MessageErrorType) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.isSpringLoaded = true
        alert.view?.layer.cornerRadius = 8
        alert.view.backgroundColor = .clear
        // Create custom MessageView
        let customView = MessageView(frame: .zero, errorData: errorData)
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
}





