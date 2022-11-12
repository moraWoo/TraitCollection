//
//  ViewController.swift
//  TraitCollection
//
//  Created by Ildar Khabibullin on 11.11.2022.
//

import UIKit

enum OrientationOfScreen: Int {
    case unknown
    case portrait
    case portraitUpsideDown
    case landscapeLeft
    case landscapeRight
    case faceUp
    case faceDown
}

class MainViewController: UIViewController {

    var orientationScreen: OrientationOfScreen!

    var indexOfOrientation = 0

    private var sharedConstraintsPortrait: [NSLayoutConstraint] = []
    private var sharedConstraintsLandscape: [NSLayoutConstraint] = []

    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []

    var stackView = UIStackView()
    var heightOfView = CGFloat()

    private lazy var viewTopLeft: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan

        view.alpha = 0.8
        return view
    }()

    private lazy var viewBottomRight: UIView = {
        let view = UIView()
        view.backgroundColor = .orange

        view.alpha = 0.8
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(viewTopLeft)
        view.addSubview(viewBottomRight)
        viewTopLeft.translatesAutoresizingMaskIntoConstraints = false
        viewBottomRight.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
//        NSLayoutConstraint.activate(sharedConstraintsPortrait)
        layoutTrait(traitCollection: UIScreen.main.traitCollection)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientationChanged),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }


    @objc func orientationChanged(_ notification: NSNotification) {
        indexOfOrientation = UIDevice.current.orientation.rawValue
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layoutTrait(traitCollection: traitCollection)
    }

    func setupConstraints() {

        let verticalSpace = NSLayoutConstraint(
            item: self.viewBottomRight,
            attribute: .top,
            relatedBy: .equal,
            toItem: viewTopLeft,
            attribute: .bottom,
            multiplier: 1,
            constant: 16
        )

        let equalRationViewTopLeft = NSLayoutConstraint(
            item: viewTopLeft,
            attribute: .width,
            relatedBy: .equal,
            toItem: viewTopLeft,
            attribute: .height,
            multiplier: 1,
            constant: 0
        )

        let horizontalSpace = NSLayoutConstraint(
            item: self.viewTopLeft,
            attribute: .right,
            relatedBy: .equal,
            toItem: viewBottomRight,
            attribute: .left,
            multiplier: 1,
            constant: -24
        )

        let equalRationViewBottomRight = NSLayoutConstraint(
            item: self.viewBottomRight,
            attribute: .width,
            relatedBy: .equal,
            toItem: viewBottomRight,
            attribute: .height,
            multiplier: 1,
            constant: 0
        )

        sharedConstraintsPortrait.append(contentsOf: [
            viewTopLeft.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            viewTopLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            viewTopLeft.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            verticalSpace,
            equalRationViewTopLeft,

            viewBottomRight.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            viewBottomRight.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            viewBottomRight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])

        sharedConstraintsLandscape.append(contentsOf: [
            viewTopLeft.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 24),
            viewTopLeft.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            viewTopLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),

            horizontalSpace,
            equalRationViewTopLeft,
            equalRationViewBottomRight,

            viewBottomRight.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            viewBottomRight.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
        ])

        regularConstraints.append(contentsOf: [

            viewTopLeft.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 24),
            viewTopLeft.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            viewTopLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),

            horizontalSpace,
            equalRationViewTopLeft,

            viewBottomRight.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            viewBottomRight.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            viewBottomRight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
        ])

        compactConstraints.append(contentsOf: [
            viewTopLeft.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            viewTopLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            viewTopLeft.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            verticalSpace,
            equalRationViewTopLeft,

            viewBottomRight.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            viewBottomRight.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            viewBottomRight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }

    func layoutTrait(traitCollection: UITraitCollection) {

//        if (!sharedConstraintsPortrait[0].isActive) && (!sharedConstraintsLandscape[0].isActive) {
//            orientationScreen = OrientationOfScreen(rawValue: indexOfOrientation)
//
//            switch orientationScreen {
//                case .landscapeRight:
//                    NSLayoutConstraint.deactivate(sharedConstraintsPortrait)
//                    NSLayoutConstraint.deactivate(sharedConstraintsLandscape)
//                    NSLayoutConstraint.activate(sharedConstraintsLandscape)
//                    print("landscapeRight")
//                case .portrait:
//                    NSLayoutConstraint.deactivate(sharedConstraintsPortrait)
//                    NSLayoutConstraint.deactivate(sharedConstraintsLandscape)
//                    NSLayoutConstraint.activate(sharedConstraintsPortrait)
//                    print("portrait")
//                case .landscapeLeft:
//                    print("landscapeLeft")
//                case .unknown:
//                    print("Unknown orientation")
//                case .faceDown:
//                    print("FaceDown orientation")
//                case .faceUp:
//                    print("FaceUp orientation")
//                default:
//                    print("PortraitUpsideDown orientation")
//            }
//         }

        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {

                NSLayoutConstraint.deactivate(regularConstraints)
            }
            NSLayoutConstraint.deactivate(sharedConstraintsLandscape)
//            NSLayoutConstraint.deactivate(sharedConstraintsPortrait)

            NSLayoutConstraint.activate(compactConstraints)
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
//            NSLayoutConstraint.deactivate(sharedConstraintsLandscape)
            NSLayoutConstraint.deactivate(sharedConstraintsPortrait)

            NSLayoutConstraint.activate(regularConstraints)
        }
    }
}

