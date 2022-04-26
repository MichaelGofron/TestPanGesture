
import Foundation
import UIKit

class SecondViewController: OverlayViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSlider()
    }

    func addSlider() {
        let sliderWidth:CGFloat = 100
        let centerOfScreen = self.view.frame.size.width / 2
        let rect = CGRect(x: centerOfScreen - sliderWidth/2, y: 80, width: sliderWidth, height: 10)
        let slider = UIView(frame: rect)
        slider.backgroundColor = .black
        self.view.addSubview(slider)
    }
}
