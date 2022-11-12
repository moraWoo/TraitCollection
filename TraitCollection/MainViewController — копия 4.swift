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

    let orientation: [String] = [
        "unknown",
        "portrait",
        "portraitUpsideDown",
        "landscapeLeft",
        "landscapeRight",
        "faceUp",
        "faceDown"
    ]

    private var sharedConstraintsPortrait: [NSLayoutConstraint] = []
    private var sharedConstraintsLandscape: [NSLayoutConstraint] = []

    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []

    var stackView = UIStackView()
    var heightOfView = CGFloat()

    private lazy var viewTopLeft: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.8
        return view
    }()

    private lazy var viewBottomRight: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.8
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(viewTopLeft)
        view.addSubview(viewBottomRight)

        setupConstraints()

//        orientationScreen = OrientationOfScreen(rawValue: indexOfOrientation)
//
//        switch orientationScreen {
//            case .landscapeRight:
//                NSLayoutConstraint.activate(sharedConstraintsLandscape)
//                print("landscapeRight")
//            case .landscapeLeft:
//                NSLayoutConstraint.activate(sharedConstraintsLandscape)
//                print("landscapeLeft")
//            case .portrait:
//                NSLayoutConstraint.activate(sharedConstraintsPortrait)
//                print("portrait")
//            case .unknown:
//                print("Unknown orientation")
//            case .faceDown:
//                print("FaceDown orientation")
//            case .faceUp:
//                print("FaceUp orientation")
//            default:
//                print("PortraitUpsideDown orientation")
//        }

//        if UIApplication.shared.statusBarOrientation.isPortrait {
//            NSLayoutConstraint.activate(sharedConstraintsPortrait)
//        } else {
//            NSLayoutConstraint.activate(sharedConstraintsLandscape)
//        }

//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(orientationChanged),
//            name: UIDevice.orientationDidChangeNotification,
//            object: nil
//        )

        layoutTrait(traitCollection: UIScreen.main.traitCollection)
    }

    @objc func orientationChanged(_ notification: NSNotification) {
//        print("1-------- \(orientation[UIDevice.current.orientation.rawValue])")
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
            item: self.viewTopLeft,
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
            viewTopLeft.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            viewTopLeft.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            viewTopLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            horizontalSpace,
            equalRationViewTopLeft,

            viewBottomRight.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            viewBottomRight.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
        ])

        regularConstraints.append(contentsOf: [
            viewTopLeft.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            viewTopLeft.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            viewTopLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),

            horizontalSpace,
            equalRationViewTopLeft,

            viewBottomRight.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            viewBottomRight.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            viewBottomRight.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -60),
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

        if (!sharedConstraintsPortrait[0].isActive) || (!sharedConstraintsLandscape[0].isActive) {
            orientationScreen = OrientationOfScreen(rawValue: indexOfOrientation)

            switch orientationScreen {
                case .landscapeRight:
                    NSLayoutConstraint.activate(sharedConstraintsLandscape)
                    print("landscapeRight")
                case .landscapeLeft:
                    NSLayoutConstraint.activate(sharedConstraintsLandscape)
                    print("landscapeLeft")
                case .portrait:
                    NSLayoutConstraint.activate(sharedConstraintsPortrait)
                    print("portrait")
                case .unknown:
                    print("Unknown orientation")
                case .faceDown:
                    print("FaceDown orientation")
                case .faceUp:
                    print("FaceUp orientation")
                default:
                    print("PortraitUpsideDown orientation")
            }

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(orientationChanged),
                name: UIDevice.orientationDidChangeNotification,
                object: nil
            )
         }

        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(sharedConstraintsLandscape)
                NSLayoutConstraint.deactivate(sharedConstraintsPortrait)
                NSLayoutConstraint.deactivate(regularConstraints)
            }
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(sharedConstraintsLandscape)
                NSLayoutConstraint.deactivate(sharedConstraintsPortrait)
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
}

