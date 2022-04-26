//
//  ViewController.swift
//  TestPanGesture
//
//  Created by Michael Gofron on 4/26/22.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    private let button = UIView.init()

override func viewDidLoad() {
    super.viewDidLoad()
    
    button.backgroundColor = .blue
    let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(buttonPressed))
    button.addGestureRecognizer(tapGesture)
    self.view.addSubview(button)
}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        button.frame = CGRect.init(x: 40, y: 40, width: 300, height: 100)
    }

@objc func buttonPressed(_ sender: Any) {
    showOverlay()
}

func showOverlay() {
    let secondVC = SecondViewController.init()
    secondVC.modalPresentationStyle = .custom
    secondVC.transitioningDelegate = self
    self.present(secondVC, animated: true, completion: nil)
}
}

extension ViewController: UIViewControllerTransitioningDelegate {
func presentationController(forPresented presented: UIViewController,
                            presenting: UIViewController?,
                            source: UIViewController) -> UIPresentationController?
{
    let presentedHeight: CGFloat = 1.0
    let controller = PresentationController(presentedViewController: presented,
                                            presenting: presenting,
                                            backgroundEffect: .dim,
                                            viewHeight: presentedHeight)

    if let vc = presented as? OverlayViewController {
        vc.delegate = controller
    }
    return controller
 }
}

