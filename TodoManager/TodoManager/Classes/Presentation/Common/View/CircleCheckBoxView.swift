//
//  CircleCheckBoxView.swift
//  TodoManager
//
//  Created by Anton Polyakov on 13/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


/// Checkbox is a simple, animation free checkbox and UISwitch alternative designed
/// to be performant and easy to implement.
@IBDesignable
class CircleCheckBoxView: UIControl {
    
    // MARK: - Properties
    
    /// Width of the borders stroke.
    ///
    /// **NOTE**
    ///
    /// Diagonal/rounded lines tend to appear thicker, so border styles
    /// that use these (.circle) have had their border widths halved to compensate
    /// in order appear similar next to other border styles.
    ///
    /// **Default:** `4`
    @IBInspectable
    var borderWidth: CGFloat = 5
    
    /// Size of the center checkmark element.
    ///
    /// Drawn as a percentage of the size of the Checkbox's draw rect.
    ///
    /// **Default:** `0.5`
    @IBInspectable
    var checkmarkSize: CGFloat = 0.5
    
    /// **Default:** The current tintColor.
    var uncheckedBorderColor: UIColor!
    var checkedBorderColor: UIColor!
    
    /// **Default:** The current tintColor.
    var checkmarkColor: UIColor!
    
    /// **Default:** White.
    var checkboxBackgroundColor: UIColor! = .white
    
    /// Increases the controls touch area.
    ///
    /// Checkbox's tend to be smaller than regular UIButton elements
    /// and in some cases making them difficult to interact with.
    /// This property helps with that.
    ///
    /// **Default:** `5`
    var increasedTouchRadius: CGFloat = 5
    
    /// A function can be passed in here and will be called
    /// when the `isChecked` value changes due to a tap gesture
    /// triggered by the user.
    ///
    /// An alternative to use the TargetAction method.
    var valueChanged: ((_ isChecked: Bool) -> Void)?
    
    /// Indicates whether the checkbox is currently in a state of being
    /// checked or not.
    @IBInspectable
    public var isChecked: Bool = false {
        didSet { setNeedsDisplay() }
    }
    
    
    // MARK: - Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaults()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDefaults()
    }
    
    private func setupDefaults() {
        uncheckedBorderColor = tintColor
        checkedBorderColor = tintColor
        checkmarkColor = tintColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(recognizer:)))
        addGestureRecognizer(tapGesture)
    }
    
    override public func draw(_ rect: CGRect) {
        drawCircleBorder(in: rect)
        if isChecked {
            drawCircleCheckmark(in: rect)
        }
    }
    
    
    // MARK: - Borders
    
    private func drawCircleBorder(in rect: CGRect) {
        let adjustedRect = CGRect(x: borderWidth / 2,
                                  y: borderWidth / 2,
                                  width: rect.width - borderWidth,
                                  height: rect.height - borderWidth)
        
        circleBorder(rect: adjustedRect)
    }
    
    private func circleBorder(rect: CGRect) {
        let ovalPath = UIBezierPath(ovalIn: rect)
        
        if isChecked {
            checkedBorderColor.setStroke()
        } else {
            uncheckedBorderColor.setStroke()
        }
        
        ovalPath.lineWidth = borderWidth / 2
        ovalPath.stroke()
        checkboxBackgroundColor.setFill()
        ovalPath.fill()
    }
    
    
    // MARK: - Checkmarks
    
    private func drawCircleCheckmark(in rect: CGRect) {
        let adjustedRect = checkmarkRect(in: rect)
        circleCheckmark(rect: adjustedRect)
    }
    
    private func circleCheckmark(rect: CGRect) {
        let ovalPath = UIBezierPath(ovalIn: rect)
        checkmarkColor.setFill()
        ovalPath.fill()
    }
    
    
    // MARK: - Size Calculations
    
    private func checkmarkRect(in rect: CGRect) -> CGRect {
        let width = rect.maxX * checkmarkSize
        let height = rect.maxY * checkmarkSize
        let adjustedRect = CGRect(x: (rect.maxX - width) / 2,
                                  y: (rect.maxY - height) / 2,
                                  width: width,
                                  height: height)
        return adjustedRect
    }
    
    
    // MARK: - Touch
    
    @objc private func handleTapGesture(recognizer: UITapGestureRecognizer) {
        isChecked = !isChecked
        valueChanged?(isChecked)
        sendActions(for: .valueChanged)
    }
    
    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let relativeFrame = self.bounds
        let hitTestEdgeInsets = UIEdgeInsets(
            top: -increasedTouchRadius,
            left: -increasedTouchRadius,
            bottom: -increasedTouchRadius,
            right: -increasedTouchRadius)
        let hitFrame = UIEdgeInsetsInsetRect(relativeFrame, hitTestEdgeInsets)
        return hitFrame.contains(point)
    }
    
}
