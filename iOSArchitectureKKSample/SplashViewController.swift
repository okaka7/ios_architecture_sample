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
        let imageView: UIImageView = .init(image: #imageLiteral(resourceName: "splahIcon"))
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
        imageView.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: onethirdHeight).isActive = true
        return imageView
    }()
    
    
    lazy private(set) var iconLabel: UILabel = {
        let label: UILabel = .init()
        label.text = "light"
        label.textColor = .white
        
        label.textAlignment = .center
        label.font = UIFont.init(name: "Hoefler Text", size: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        label.sizeToFit()
        let width: CGFloat = label.frame.width
        let height: CGFloat = label.frame.height
        
        label.widthAnchor.constraint(equalToConstant: width).isActive = true
        label.heightAnchor.constraint(equalToConstant: height).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        let distance: CGFloat = Const.Size.Splash.marginBetweenIconAndMainLabel
        label.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: distance).isActive = true
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    lazy private(set) var iconSubLabel: UILabel = {
        // Note: setting labelText
        // Note: ラベルテキストを設定
        let fontSize: CGFloat = 19
        let mainFont: UIFont = UIFont.init(descriptor: .init(name: "Hoefler Text", size: 0), size: fontSize)
        let subFont: UIFont = UIFont.init(descriptor: .init(name: "Baskerville", size: 0), size: fontSize)
        let stringAttributes1: [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor.white,
            .font : subFont
        ]
        let string1 = NSAttributedString(string: "~ ", attributes: stringAttributes1)
        
        let stringAttributes2: [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor.white,
            .font : mainFont
        ]
        let string2 = NSAttributedString(string: "Photo Collection", attributes: stringAttributes2)
        
        let stringAttributes3: [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor.white,
            .font : subFont
        ]
        let string3 = NSAttributedString(string: " ~", attributes:stringAttributes3)
        
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(string1)
        mutableAttributedString.append(string2)
        mutableAttributedString.append(string3)
        
        // Note: setting labelSize
        // Note: ラベルサイズを設定
        let label: UILabel = .init()
        label.attributedText  = mutableAttributedString
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
        let size: CGSize = {
            return CGSize.init(width: self.view.frame.width, height: self.view.frame.height - safeareaInsets.top - safeareaInsets.bottom)
        }()
        let stars = Star.createStars(screenSize: size, insetTop: safeareaInsets.top)
        
        stars.forEach {
            self.view.layer.addSublayer($0)
        }
        return stars
    }()
    
    
    let viewModel: SplashViewModelType
    private let disposeBag: DisposeBag

    init(viewModel: SplashViewModelType,
         disposeBag: DisposeBag = DisposeBag()) {
        self.viewModel = viewModel
        self.disposeBag = disposeBag
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = #colorLiteral(red: 0.08235294118, green: 0.08235294118, blue: 0.08235294118, alpha: 1)
        self.addObserverForTransition()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        viewModel.inputs.prepareForMainTab()
    }
    
    
    private func transition(_ : Notification) {
        viewModel.inputs.transition()
    }
  
}


extension SplashViewController {
    private enum Star: CGFloat {
        case small = 1.0
        case medium = 1.5
        case large = 2.0
        case extraLarge = 3.0
        
        
        static func createStars(screenSize: CGSize, insetTop: CGFloat) -> [CAShapeLayer] {
            return starPositionAndSize.map { star in
                let circleLayer: CAShapeLayer = .init()
                let relativePosition = star.position
                let frame: CGRect = .init(x: screenSize.width * relativePosition.x,
                                          y: screenSize.height * relativePosition.y + insetTop,
                                          width: star.size.rawValue,
                                          height: star.size.rawValue)
                circleLayer.frame = frame
                // 円の中の色
                circleLayer.fillColor = UIColor.white.cgColor
                
                circleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0,
                                                               y: 0,
                                                               width: star.size.rawValue,
                                                               height: star.size.rawValue)).cgPath
                return circleLayer
            }
        }
        
        private static let starPositionAndSize: [(position:(x:CGFloat, y:CGFloat),size: Star)] = [((0.053, 0.761), .large), ((0.061, 0.915), .extraLarge),
                                                                                                  ((0.136, 0.829), .large), ((0.045, 0.667), .large), ((0.331, 0.877), .large),
                                                                                                  ((0.859, 0.052), .extraLarge), ((0.491, 0.052), .extraLarge),
                                                                                                  ((0.96, 0.69), .medium), ((0.448, 0.802), .medium), ((0.947, 0.592), .medium),
                                                                                                  ((0.973, 0.421), .medium), ((0.781, 0.239), .medium), ((0.696, 0.76), .extraLarge),
                                                                                                  ((0.643, 0.16), .extraLarge), ((0.939, 0.239), .extraLarge),
                                                                                                  ((0.965, 0.149), .large), ((0.672, 0.076), .medium), ((0.805, 0.158), .medium),
                                                                                                  ((0.325, 0.033), .large), ((0.016, 0.211), .medium), ((0.16, 0.153), .medium),
                                                                                                  ((0.021, 0.377), .extraLarge), ((0.069, 0.271), .extraLarge),
                                                                                                  ((0.952, 0.915), .extraLarge), ((0.885, 0.759), .large), ((0.811, 0.842), .large),
                                                                                                  ((0.829, 0.664), .large), ((0.76, 0.958), .extraLarge), ((0.587, 0.89), .extraLarge),
                                                                                                  ((0.211, 0.97), .large), ((0.544, 0.989), .large), ((0.896, 0.52), .large),
                                                                                                  ((0.888, 0.382), .large), ((0.101, 0.436), .medium), ((0.037, 0.514), .medium),
                                                                                                  ((0.379, 0.158), .medium), ((0.147, 0.309), .small), ((0.144, 0.759), .small),
                                                                                                  ((0.235, 0.72), .large), ((0.107, 0.587), .extraLarge), ((0.048, 0.107), .large),
                                                                                                  ((0.317, 0.092), .large), ((0.227, 0.216), .large), ((0.149, 0.057), .medium)]
    }
}
