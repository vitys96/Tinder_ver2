//
//  CardView.swift
//  Tinder_Analog
//
//  Created by Vitaly on 07/10/2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//

import UIKit
import SDWebImage

class CardView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var professionalLabel: UILabel!
    @IBOutlet weak var infoStackView: UIStackView!
    
    private let minValueOfDissappear: CGFloat = 80
    private let barsStackView = UIStackView()
    private let barDeselectedColor = UIColor(white: 0, alpha: 0.5)
    private var imageIndex = 0
    
    var imagesArray: [String] = []
    
    private var dragDistance = CGPoint.zero
    private var animationDirectionY: CGFloat = 1.0
    public var scaleMin: CGFloat = 0.8
    public var rotationMax: CGFloat = 1.0
    public var rotationAngle: CGFloat = CGFloat(Double.pi) / 10.0
    
    init(data: Data) {
        super.init(frame: .zero)
        fromNib()
        congigureUI()
        imagesArray.append(contentsOf: data.imageNames)
        let imageName = data.imageNames.first ?? ""
        if let url = URL(string: imageName) {
            imageView.sd_setImage(with: url)
        }
        nameLabel.text = data.name
        ageLabel.text = data.age
        professionalLabel.text = data.profession
        nameLabel.text = data.name
        nameLabel.font = data.nameFont
        ageLabel.font = data.ageFont
        professionalLabel.font = data.proffesionFont
        if let aligment = data.stackViewAligment {
            infoStackView.alignment = aligment
        }
        [nameLabel, ageLabel, professionalLabel].forEach( {$0.textColor = data.textColor} )
        
        
        
        (0..<data.imageNames.count).forEach { (_) in
            let barView = UIView()
            barView.backgroundColor = barDeselectedColor
            barsStackView.addArrangedSubview(barView)
        }
        barsStackView.arrangedSubviews.first?.backgroundColor = .white
    }
    
    private func congigureUI() {
        layer.cornerRadius = 10
        clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        setupBarsStackView()
        
    }
    
    private func setupBarsStackView() {
        self.addSubview(barsStackView)
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,
                             padding: .init(top: 8, left: 8, bottom: 0, right: 8),
                             size: .init(width: 0, height: 5))
        barsStackView.spacing = 4
        barsStackView.distribution = .fillEqually
    }
    
    override func layoutSubviews() {
        self.setGradientBackground(aboveLayer: imageView.layer)
    }
    
    @objc private func handleTap(gesture: UIPanGestureRecognizer) {
        let tapLocation = gesture.location(in: nil)
        let shouldNextPhoto = tapLocation.x > frame.width / 2 ? true : false
        if shouldNextPhoto {
            imageIndex = min(imageIndex + 1, imagesArray.count - 1)
        } else {
            imageIndex = max(0, imageIndex - 1)
        }
        toggleImage(images: imagesArray, index: imageIndex)
        barsStackView.arrangedSubviews.forEach { (v) in
            v.backgroundColor = barDeselectedColor
        }
        barsStackView.arrangedSubviews[imageIndex].backgroundColor = .white
    }
    private func toggleImage(images: [String], index: Int) {
        let imageName = images[index]
        if let url = URL(string: imageName) {
            imageView.sd_setImage(with: url)
        }
    }
    
    @objc private func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        dragDistance = gestureRecognizer.translation(in: self)
        let touchLocation = gestureRecognizer.location(in: self)
        
        switch gestureRecognizer.state {
        case .began:
            let firstTouchPoint = gestureRecognizer.location(in: self)
            let newAnchorPoint = CGPoint(x: firstTouchPoint.x / bounds.width, y: firstTouchPoint.y / bounds.height)
            let oldPosition = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)
            let newPosition = CGPoint(x: bounds.size.width * newAnchorPoint.x, y: bounds.size.height * newAnchorPoint.y)
            layer.anchorPoint = newAnchorPoint
            layer.position = CGPoint(x: layer.position.x - oldPosition.x + newPosition.x, y: layer.position.y - oldPosition.y + newPosition.y)
            animationDirectionY = touchLocation.y >= frame.size.height / 2 ? -1.0 : 1.0
            layer.rasterizationScale = UIScreen.main.scale
            layer.shouldRasterize = true
            
        case .changed:
            let rotationStrength = min(dragDistance.x / frame.width, rotationMax)
            let rotationAngle = animationDirectionY * self.rotationAngle * rotationStrength
            let scaleStrength = 1 - ((1 - scaleMin) * abs(rotationStrength))
            let scale = max(scaleStrength, scaleMin)
            var transform = CATransform3DIdentity
            transform = CATransform3DScale(transform, scale, scale, 1)
            transform = CATransform3DRotate(transform, rotationAngle, 0, 0, 1)
            transform = CATransform3DTranslate(transform, dragDistance.x, dragDistance.y, 0)
            layer.transform = transform
            
        case .ended:
            layer.shouldRasterize = false
            handleEnded(gesture: gestureRecognizer)
            
        default:
            ()
        }
    }
    
    private func handleEnded(gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > minValueOfDissappear
        
        if shouldDismissCard {
            if translationDirection == 1 {
                performSwipeAnimation(translation: 700, angle: 15)
            }
        } else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                self.transform = .identity
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Data {
        let name: String
        let age: String
        let profession: String
        let imageNames: [String]
        let nameFont: UIFont?
        let ageFont: UIFont?
        let proffesionFont: UIFont?
        let textColor: UIColor?
        let stackViewAligment: UIStackView.Alignment?
        
        init(name: String, age: String, profession: String, imageNames: [String],
             nameFont: UIFont? = UIFont.systemFont(ofSize: 28, weight: .heavy),
             ageFont: UIFont? = UIFont.systemFont(ofSize: 28, weight: .heavy),
             proffesionFont: UIFont? = UIFont.systemFont(ofSize: 22, weight: .regular),
             textColor: UIColor? = UIColor.white,
             stackViewAligment: UIStackView.Alignment? = .leading) {
            
            self.name = name
            self.age = age
            self.profession = profession
            self.imageNames = imageNames
            self.nameFont = nameFont
            self.ageFont = ageFont
            self.proffesionFont = proffesionFont
            self.textColor = textColor
            self.stackViewAligment = stackViewAligment
        }
    }
    
}

extension CardView {
    fileprivate func performSwipeAnimation(translation: CGFloat, angle: CGFloat) {
        let duration = 0.5
        let translationAnimation = CABasicAnimation(keyPath: "position.x")
        translationAnimation.toValue = translation
        translationAnimation.duration = duration
        translationAnimation.fillMode = .forwards
        translationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        translationAnimation.isRemovedOnCompletion = false
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = angle * CGFloat.pi / 180
        rotationAnimation.duration = duration
        
        CATransaction.setCompletionBlock {
            self.removeFromSuperview()
        }
        
        self.layer.add(translationAnimation, forKey: "translation")
        self.layer.add(rotationAnimation, forKey: "rotation")
        
        CATransaction.commit()
    }
}
