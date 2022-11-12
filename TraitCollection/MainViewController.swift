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

    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []

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
        let safeArea = view.safeAreaLayoutGuide

        regularConstraints.append(contentsOf: [
            viewTopLeft.topAnchor.constraint(equalTo: safeArea.topAnchor),
            viewTopLeft.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            viewTopLeft.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
            viewTopLeft.heightAnchor.constraint(equalTo: safeArea.heightAnchor),

            viewBottomRight.topAnchor.constraint(equalTo: safeArea.topAnchor),
            viewBottomRight.leadingAnchor.constraint(equalTo: viewTopLeft.trailingAnchor),
            viewBottomRight.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
            viewBottomRight.heightAnchor.constraint(equalTo: safeArea.heightAnchor)
        ])

        compactConstraints.append(contentsOf: [
            viewTopLeft.topAnchor.constraint(equalTo: safeArea.topAnchor),
            viewTopLeft.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            viewTopLeft.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            viewTopLeft.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.5),

            viewBottomRight.topAnchor.constraint(equalTo: viewTopLeft.bottomAnchor),
            viewBottomRight.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            viewBottomRight.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            viewBottomRight.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.5)
        ])
    }

    func layoutTrait(traitCollection: UITraitCollection) {
        switch orientationScreen {
            case .landscapeRight:
                print("landscapeRight")
            case .portrait:
                print("portrait")
            case .landscapeLeft:
                print("landscapeLeft")
            case .unknown:
                print("Unknown orientation")
            case .faceDown:
                print("FaceDown orientation")
            case .faceUp:
                print("FaceUp orientation")
            default:
                print("PortraitUpsideDown orientation")
        }

        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
            }
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
}

