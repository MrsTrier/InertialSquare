//
//  InertialSquareViewController.swift
//  InertialSquare
//
//  Created by Daria Cheremina on 17/11/2024.
//

import UIKit

class InertialSquareViewController: UIViewController {

    private lazy var viewToAnimate: UIView = {
        let view = UIImageView(image: UIImage(named: "Otets"))
        view.clipsToBounds = true
        view.layer.cornerRadius = 100 / 6
        view.isUserInteractionEnabled = true

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()


        view.backgroundColor = .white
        setupLayout()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action:
                                                            #selector (self.handleTapGesture)))
    }

    private func setupLayout() {
        view.addSubview(viewToAnimate)
        viewToAnimate.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            viewToAnimate.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewToAnimate.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            viewToAnimate.widthAnchor.constraint(equalToConstant: 100),
            viewToAnimate.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupAnimator(newDestination: CGPoint, rotationAngle: CGFloat) -> UIViewPropertyAnimator {
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            self.viewToAnimate.transform = CGAffineTransform(rotationAngle: rotationAngle)

            self.viewToAnimate.center = newDestination

        }
        animator.addCompletion({ [weak self] _ in
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {

                self?.viewToAnimate.transform = .identity
            })
        })
        return animator
    }

    @objc func handleTapGesture(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)

        var coordinateX = location.x < view.frame.minX + 60 ? 60 : location.x
        coordinateX = coordinateX > view.frame.maxX - 60 ? view.frame.maxX - 60 : coordinateX

        var coordinateY = location.y < view.safeAreaInsets.top + 50 ? view.safeAreaInsets.top + 50 : location.y
        coordinateY = coordinateY > view.frame.maxY - 70 ? view.frame.maxY - 70 : coordinateY

        let rotationAngleMultiplier: CGFloat = viewToAnimate.center.x > location.x ? -1 : 1

        let animator = setupAnimator(newDestination: CGPoint(x: coordinateX, y: coordinateY), rotationAngle: rotationAngleMultiplier * CGFloat(Float.pi / 6))
        animator.startAnimation()
    }
}
