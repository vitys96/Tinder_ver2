//
//  CardView.swift
//  Tinder_Analog
//
//  Created by Vitaly on 07/10/2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//

import UIKit

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
    
    init(data: Data) {
        super.init(frame: .zero)
        fromNib()
        congigureUI()
        imagesArray.append(contentsOf: data.imageNames)
        nameLabel.text = data.name
        if let age = data.age {
            ageLabel.text = age
        } else {
            ageLabel.isHidden = true
        }
        
        professionalLabel.text = data.profession
        nameLabel.text = data.name
        nameLabel.font = data.nameFont
        ageLabel.font = data.ageFont
        professionalLabel.font = data.proffesionFont
        if let aligment = data.stackViewAligment {
            infoStackView.alignment = aligment
        }
        [nameLabel, ageLabel, professionalLabel].forEach( {$0.textColor = data.textColor} )
        
        let imageName = data.imageNames.first ?? ""
        imageView.image = UIImage(named: imageName)
        
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
        imageView.image = UIImage(named: imageName)
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture: gesture)
        default:
            ()
        }
    }
    
    private func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    private func handleEnded(gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > minValueOfDissappear
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                self.frame = CGRect(x: 600 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
            } else {
                self.transform = .identity
            }
            
        }) { (_) in
            self.transform = .identity
            if shouldDismissCard {
                self.removeFromSuperview()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Data {
        let name: String
        let age: String?
        let profession: String
        let imageNames: [String]
        let nameFont: UIFont?
        let ageFont: UIFont?
        let proffesionFont: UIFont?
        let textColor: UIColor?
        let stackViewAligment: UIStackView.Alignment?
        var didSelectImageIndex: ((Int) -> Void)?
        
        init(name: String, age: String?, profession: String, imageNames: [String],
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
