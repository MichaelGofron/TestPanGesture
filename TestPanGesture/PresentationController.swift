
import Foundation
import UIKit

class PresentationController: UIPresentationController {

  private var backgroundEffectView: UIView?
  private var backgroundEffect: BackgroundEffect?
private var viewHeight: CGFloat?
private let maxDim:CGFloat = 0.6
private var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()

convenience init(presentedViewController: UIViewController,
               presenting presentingViewController: UIViewController?,
               backgroundEffect: BackgroundEffect = .blur,
               viewHeight: CGFloat = 0.6)
{

  self.init(presentedViewController: presentedViewController, presenting: presentingViewController)

  self.backgroundEffect = backgroundEffect
  self.backgroundEffectView = returnCorrectEffectView(backgroundEffect)
  self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
  self.backgroundEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  self.backgroundEffectView?.isUserInteractionEnabled = true
  self.backgroundEffectView?.addGestureRecognizer(tapGestureRecognizer)
  self.viewHeight = viewHeight
}

private override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
  super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
}

override var frameOfPresentedViewInContainerView: CGRect {
  CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * (1-viewHeight!)),
         size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height *
                          viewHeight!))
}
    
    override func presentationTransitionWillBegin() {
         self.backgroundEffectView?.alpha = 0
         self.containerView?.addSubview(backgroundEffectView!)
         self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
             switch self.backgroundEffect! {
             case .blur:
                 self.backgroundEffectView?.alpha = 1
             case .dim:
                 self.backgroundEffectView?.alpha = self.maxDim
             case .none:
                 self.backgroundEffectView?.alpha = 0
             }
         }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
     }

     override func dismissalTransitionWillBegin() {
         self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
             self.backgroundEffectView?.alpha = 0
         }, completion: { (UIViewControllerTransitionCoordinatorContext) in
             self.backgroundEffectView?.removeFromSuperview()
         })
     }

     override func containerViewWillLayoutSubviews() {
         super.containerViewWillLayoutSubviews()
     }

     override func containerViewDidLayoutSubviews() {
         super.containerViewDidLayoutSubviews()
         presentedView?.frame = frameOfPresentedViewInContainerView
         backgroundEffectView?.frame = containerView!.bounds
     }

     @objc func dismissController(){
         self.presentedViewController.dismiss(animated: true, completion: nil)
     }

     func graduallyChangeOpacity(withPercentage: CGFloat) {
         self.backgroundEffectView?.alpha = withPercentage
     }

     func returnCorrectEffectView(_ effect: BackgroundEffect) -> UIView {
         switch effect {

         case .blur:
             var blurEffect = UIBlurEffect(style: .dark)
             if self.traitCollection.userInterfaceStyle == .dark {
                 blurEffect = UIBlurEffect(style: .light)
             }
             return UIVisualEffectView(effect: blurEffect)
         case .dim:
             var dimView = UIView()
             dimView.backgroundColor = .black
             if self.traitCollection.userInterfaceStyle == .dark {
                 dimView.backgroundColor = .gray
             }
             dimView.alpha = maxDim
             return dimView
         case .none:
             let clearView = UIView()
             clearView.backgroundColor = .clear
             return clearView
         }
        }
       }

         extension PresentationController: OverlayViewDelegate {
         func userDragged(draggedPercentage: CGFloat) {
         graduallyChangeOpacity(withPercentage: 1-draggedPercentage)

         switch self.backgroundEffect! {
         case .blur:
             graduallyChangeOpacity(withPercentage: 1-draggedPercentage)
         case .dim:
             graduallyChangeOpacity(withPercentage: maxDim-draggedPercentage)
         case .none:
             self.backgroundEffectView?.alpha = 0
         }
     }

     func animateBlurBack(seconds: TimeInterval) {
         UIView.animate(withDuration: seconds) {
             switch self.backgroundEffect! {
             case .blur:
                 self.backgroundEffectView?.alpha = 1
             case .dim:
                 self.backgroundEffectView?.alpha = self.maxDim
             case .none:
                 self.backgroundEffectView?.alpha = 0
             }

         }
       }
      }

       enum BackgroundEffect {
        case blur
        case dim
        case none
       }
