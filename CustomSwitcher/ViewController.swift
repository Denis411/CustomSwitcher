//
//  ViewController.swift
//  CustomSwitcher
//
//  Created by Dennis Loskutov on 14.03.2022.
//

import UIKit

class ViewController: UIViewController {
    let switcher  = LockSwitcher()
    let button = UIButton()
    var hasLock = true

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUpSwitcher()
        setUpButton()
    }
    
    private func setUpSwitcher() {
        view.addSubview(switcher)
        switcher.center = view.center
        switcher.hasLock(hasLock)
    }
    
    private func setUpButton() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Lock true/false", for: .normal)
        button.layer.cornerRadius = 7
        button.setTitle("caught", for: .highlighted)
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        button.addTarget(self, action: #selector(lock), for: .touchUpInside)
    }
    
    @objc private func lock() {
        hasLock.toggle()
        switcher.hasLock(hasLock)
    }
}


/// Custom UISwitch
/// - Method hasLock: use to display a lock image on the thumb of the switcher,
/// the image is not used by default
final class LockSwitcher: UISwitch {
    let imageView: UIImageView = {
        let image = UIImage(named: "lock_for_switcher")
        let imageView = UIImageView(image: image)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpColors()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpColors()
    }

    private func setUpImageView() {
        let subview = self.subviews.last?.subviews.last
        let thumb = subview?.subviews.last
        thumb?.addSubview(imageView)
        imageView.center.x = thumb!.bounds.midX
        imageView.center.y = thumb!.center.y
    }

    private func setUpColors() {
        self.layer.cornerRadius = 16
        self.backgroundColor = .blue
        self.onTintColor = .green
        imageView.tintColor = .orange
    }

    /// Adds a lock image on a UISwitch's  thumb
    /// - Parameter bool: has a picture if ture
    public func hasLock(_ bool: Bool) {
        switch bool {
        case true:
            setUpImageView()
            self.isUserInteractionEnabled = false
        case false:
            imageView.removeFromSuperview()
            self.isUserInteractionEnabled = true
        }
        self.setNeedsDisplay()
    }
}
