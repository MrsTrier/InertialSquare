//
//  InertialSquareViewController.swift
//  InertialSquare
//
//  Created by Daria Cheremina on 17/11/2024.
//

import UIKit

class InertialSquareViewController: UIViewController {

    private var snap: UISnapBehavior?
    private var animator: UIDynamicAnimator?

    private lazy var viewToAnimate: UIView = {
        let view = UIImageView(image: UIImage(named: "rabbit"))

        view.frame = CGRect(
            x: self.view.center.x - 50,
            y: self.view.center.y - 50,
            width: 100,
            height: 100
        )

        view.layer.cornerRadius = 100 / 6
        view.clipsToBounds = true

        view.layer.borderColor = CGColor(gray: 0, alpha: 0.5)
        view.layer.borderWidth = 1

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(viewToAnimate)

        animator = UIDynamicAnimator(referenceView: view)

        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(self.handleTapGesture)
            )
        )
    }

    @objc func handleTapGesture(gesture: UITapGestureRecognizer) {
        let tapPoint = gesture.location(in: view)

        let targetLocation = getLocationConsideringBorders(from: tapPoint, ifInsets: 10)

        if let animator {
            if let snap {
                animator.removeBehavior(snap)
            }

            let newSnap = UISnapBehavior(item: viewToAnimate, snapTo: targetLocation)
            newSnap.damping = 1.5

            snap = newSnap

            animator.addBehavior(newSnap)
        }
    }

    private func getLocationConsideringBorders(from tapPoint: CGPoint, ifInsets inset: CGFloat) -> CGPoint {
        var coordinateX = tapPoint.x < view.frame.minX + 50 + inset
            ? 50 + inset
            : tapPoint.x

        coordinateX = coordinateX > view.frame.maxX - 50 - inset
            ? view.frame.maxX - 50 - inset
            : coordinateX

        var coordinateY = tapPoint.y < view.frame.minY + 50 + view.safeAreaInsets.top
            ? view.frame.minY + 50 + view.safeAreaInsets.top
            : tapPoint.y

        coordinateY = coordinateY > view.frame.maxY - 50 - view.safeAreaInsets.bottom
            ? view.frame.maxY - 50 - view.safeAreaInsets.bottom
            : coordinateY

        return CGPoint(x: coordinateX, y: coordinateY)
    }
}
