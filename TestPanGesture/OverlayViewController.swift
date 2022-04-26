import UIKit

class OverlayViewController: UIViewController {

var hasSetPointOrigin = false
var pointOrigin: CGPoint?
var delegate: OverlayViewDelegate?

override func viewDidLoad() {
 super.viewDidLoad()
 let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
 view.addGestureRecognizer(panGesture)

}

override func viewDidLayoutSubviews() {
 if !hasSetPointOrigin {
  hasSetPointOrigin = true
  pointOrigin = self.view.frame.origin
 }
}
@objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
 let translation = sender.translation(in: view)

// Not allowing the user to drag the view upward
guard translation.y >= 0 else { return }
let currentPosition = translation.y
let originPos = self.pointOrigin
delegate?.userDragged(draggedPercentage: translation.y/originPos!.y)

// setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)

if sender.state == .ended {
  let dragVelocity = sender.velocity(in: view)
  if dragVelocity.y >= 1100 {
      self.dismiss(animated: true, completion: nil)
  } else {
      // Set back to original position of the view controller
      UIView.animate(withDuration: 0.3) {
          self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
          self.delegate?.animateBlurBack(seconds: 0.3)
      }
  }
}
}
}

protocol OverlayViewDelegate: AnyObject {
func userDragged(draggedPercentage: CGFloat)
func animateBlurBack(seconds: TimeInterval)
}
