//
//  ViewController.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import RxSwift

extension Notification.Name {
    static let transitionToMainTab = Notification.Name(rawValue: "toMainTab")
}

class SplashViewController: UIViewController {
    
    lazy private(set) var iconImageView: UIImageView = {
        let imageView: UIImageView = .init(image: R.image.splahIcon())
        let size: CGSize = Const.Size.Splash.iconSize
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        let guide: UILayoutGuide = self.view.safeAreaLayoutGuide
        imageView.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        //Note: iconImageViewの中心YがTopから画面の高さ1/3の位置に配置されるように設定
        //Note: set the iconImageView's centerY on the one-third screen height from the top.
        let onethirdHeight: CGFloat = (self.view.frame.height - self.view.safeAreaInsets.bottom) / 3
        imageView.centerYAnchor
            .constraint(equalTo: guide.topAnchor, constant: onethirdHeight)
            .isActive = true
        
        return imageView
    }()
    
    lazy private(set) var iconLabel: UILabel = {
        let label: UILabel = .init()
        label.text = R.string.localizable.appName()
        label.textColor = .white
        
        label.textAlignment = .center
        label.font = UIFont.init(name: "Hoefler Text", size: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        label.sizeToFit()
        let width: CGFloat = label.frame.width
        let height: CGFloat = label.frame.height
        
        label.widthAnchor
            .constraint(equalToConstant: width)
            .isActive = true
        label.heightAnchor
            .constraint(equalToConstant: height)
            .isActive = true
        label.centerXAnchor
            .constraint(equalTo: self.view.centerXAnchor)
            .isActive = true
        let distance: CGFloat = Const.Size.Splash.marginBetweenIconAndMainLabel
        label.topAnchor
            .constraint(equalTo: iconImageView.bottomAnchor, constant: distance)
            .isActive = true
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy private(set) var iconSubLabel: UILabel = {
        // Note: setting labelText
        // Note: ラベルテキストを設定
        let fontSize: CGFloat = 19
        let mainFont: UIFont = .init(descriptor: .init(name: "Hoefler Text", size: 0), size: fontSize)
        let subFont: UIFont = .init(descriptor: .init(name: "Baskerville", size: 0), size: fontSize)
        let stringAttributes1: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: subFont
        ]
        let string1: NSAttributedString = .init(string: "~ ", attributes: stringAttributes1)
        
        let stringAttributes2: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: mainFont
        ]
        let string2 = NSAttributedString(string: "Photo Collection", attributes: stringAttributes2)
        
        let stringAttributes3: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: subFont]
        let string3: NSAttributedString = .init(string: " ~", attributes: stringAttributes3)
        
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(string1)
        mutableAttributedString.append(string2)
        mutableAttributedString.append(string3)
        
        // Note: setting labelSize
        // Note: ラベルサイズを設定
        let label: UILabel = .init()
        label.attributedText = mutableAttributedString
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        label.sizeToFit()
        let width: CGFloat = label.frame.width
        let height: CGFloat = label.frame.height
        
        label.widthAnchor.constraint(equalToConstant: width).isActive = true
        label.heightAnchor.constraint(equalToConstant: height).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        let distance: CGFloat = Const.Size.Splash.marginBetweenMainLabelAndSubLabel
        label.topAnchor.constraint(equalTo: self.iconLabel.bottomAnchor, constant: 5).isActive = true
        
        return label
    }()
    
    lazy private var startLayers: [CAShapeLayer] = {
        let safeareaInsets = self.view.safeAreaInsets
        print(safeareaInsets)
        let size: CGSize = {
            let viewHeight: CGFloat = self.view.frame.height - safeareaInsets.top - safeareaInsets.bottom
            return CGSize.init(width: self.view.frame.width, height: viewHeight)
        }()
        let stars = Star.createStars(viewSize: size, insetTop: safeareaInsets.top)
        
        stars.forEach {
            self.view.layer.addSublayer($0)
        }
        return stars
    }()
    
    private let viewModel: SplashViewModelType
    private let disposeBag: DisposeBag = DisposeBag()

    init(viewModel: SplashViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = #colorLiteral(red: 0.08235294118, green: 0.08235294118, blue: 0.08235294118, alpha: 1)
        self.addObserverForTransition()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupViews()
    }
    
    private func setupViews() {
        _ = iconImageView
        _ = iconLabel
        _ = iconSubLabel
        _ = startLayers
    }
    
    private func addObserverForTransition() {
        _ = NotificationCenter.default
            .addObserver(forName: .transitionToMainTab,
                         object: nil,
                         queue: nil,
                         using: transition(_:))
    }
    
    func prepareForMainTab() {
        //viewModel.inputs.prepareForMainTab()
    }
    
    private func transition(_ : Notification) {
        viewModel.inputs.transition()
    }
  
}

extension SplashViewController {
    
    private enum StarSize: CGFloat {
        case small = 1.0
        case medium = 1.5
        case large = 2.0
        case extraLarge = 3.0
    }
    private struct Star {
        static func createStars(viewSize: CGSize, insetTop: CGFloat) -> [CAShapeLayer] {
            return starPositionAndSize.map { star in
                let circleLayer: CAShapeLayer = .init()
                let relativePosition = star.relativePosition
                let starSize = star.size.rawValue
                let frame: CGRect = .init(x: viewSize.width * relativePosition.x,
                                          y: viewSize.height * relativePosition.y + insetTop,
                                          width: starSize,
                                          height: starSize)
                circleLayer.frame = frame
                // 円の中の色
                circleLayer.fillColor = UIColor.white.cgColor
                circleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0,
                                                               width: starSize,
                                                               height: starSize))
                                                .cgPath
                return circleLayer
            }
        }
        
        typealias StarRects = [(relativePosition: CGPoint, size: StarSize)]
        
        private static let starPositionAndSize: StarRects =
            [(CGPoint(x: 0.053, y: 0.761), .large), (CGPoint(x: 0.061, y: 0.915), .extraLarge),
             (CGPoint(x: 0.136, y: 0.829), .large), (CGPoint(x: 0.045, y: 0.667), .large),
             (CGPoint(x: 0.331, y: 0.877), .large), (CGPoint(x: 0.859, y: 0.052), .extraLarge),
             (CGPoint(x: 0.491, y: 0.052), .extraLarge), (CGPoint(x: 0.96, y: 0.69), .medium),
             (CGPoint(x: 0.696, y: 0.76), .extraLarge), (CGPoint(x: 0.947, y: 0.592), .medium),
             (CGPoint(x: 0.952, y: 0.915), .extraLarge), (CGPoint(x: 0.781, y: 0.239), .medium),
             (CGPoint(x: 0.448, y: 0.802), .medium), (CGPoint(x: 0.643, y: 0.16), .extraLarge),
             (CGPoint(x: 0.939, y: 0.239), .extraLarge), (CGPoint(x: 0.965, y: 0.149), .large),
             (CGPoint(x: 0.672, y: 0.076), .medium), (CGPoint(x: 0.805, y: 0.158), .medium),
             (CGPoint(x: 0.325, y: 0.033), .large), (CGPoint(x: 0.016, y: 0.211), .medium),
             (CGPoint(x: 0.16, y: 0.153), .medium), (CGPoint(x: 0.021, y: 0.377), .extraLarge),
             (CGPoint(x: 0.069, y: 0.271), .extraLarge), (CGPoint(x: 0.973, y: 0.421), .medium),
             (CGPoint(x: 0.885, y: 0.759), .large), (CGPoint(x: 0.811, y: 0.842), .large),
             (CGPoint(x: 0.829, y: 0.664), .large), (CGPoint(x: 0.76, y: 0.958), .extraLarge),
             (CGPoint(x: 0.587, y: 0.89), .extraLarge), (CGPoint(x: 0.211, y: 0.97), .large),
             (CGPoint(x: 0.544, y: 0.989), .large), (CGPoint(x: 0.896, y: 0.52), .large),
             (CGPoint(x: 0.888, y: 0.382), .large), (CGPoint(x: 0.101, y: 0.436), .medium),
             (CGPoint(x: 0.037, y: 0.514), .medium), (CGPoint(x: 0.379, y: 0.158), .medium),
             (CGPoint(x: 0.147, y: 0.309), .small), (CGPoint(x: 0.144, y: 0.759), .small),
             (CGPoint(x: 0.235, y: 0.72), .large), (CGPoint(x: 0.107, y: 0.587), .extraLarge),
             (CGPoint(x: 0.048, y: 0.107), .large), (CGPoint(x: 0.317, y: 0.092), .large),
             (CGPoint(x: 0.227, y: 0.216), .large), (CGPoint(x: 0.149, y: 0.057), .medium)
            ]
    }
}
