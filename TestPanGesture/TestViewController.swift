
//import Foundation
//import UIKit
//
//class TestViewController: UIViewController {
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//
//    // Do any additional setup after loading the view.
//}
//
//@IBAction func buttonPressed(_ sender: Any) {
//    showOverlay()
//}
//
//func showOverlay() {
//    let secondVC =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "secondVC") as! SecondViewController
//    secondVC.modalPresentationStyle = .custom
//    secondVC.transitioningDelegate = self
//    self.present(secondVC, animated: true, completion: nil)
//}
//}
//
//extension TestViewController: UIViewControllerTransitioningDelegate {
//func presentationController(forPresented presented: UIViewController,
//                            presenting: UIViewController?,
//                            source: UIViewController) -> UIPresentationController?
//{
//    let presentedHeight: CGFloat = 1.0
//    let controller = PresentationController(presentedViewController: presented,
//                                            presenting: presenting,
//                                            backgroundEffect: .dim,
//                                            viewHeight: presentedHeight)
//
//    if let vc = presented as? OverlayViewController {
//        vc.delegate = controller
//    }
//    return controller
// }
//}
