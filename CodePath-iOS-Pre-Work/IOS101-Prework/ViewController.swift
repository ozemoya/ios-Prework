//
//  ViewController.swift
//  IOS101-Prework
//
//  Created by Nolan Lwin on 11/14/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textLabels: [UILabel]!
    
    @IBOutlet weak var colorSlider: UISlider!
    
    // A boolean property to track the color state
    var isTextWhite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Number of labels connected: \(textLabels.count)")
        // Set the initial color of the label text to white
        textLabels.forEach {$0.textColor = .black}
        
        // Set the minimum, maximum, and middle value
        colorSlider.minimumValue = 0.0
        colorSlider.maximumValue = 1.0
        colorSlider.value = 0.5
        
        // Generate a thinner rainbow image based on the slider's width and your desired track height
        let trackHeight: CGFloat = 4.0 // Set the desired track height here
        let rainbowImage = generateRainbowImage(bounds: colorSlider.bounds, trackHeight: trackHeight)
            
        // Create a stretchable image with the left and right cap insets at half the image's width
        let stretchableRainbowImage = rainbowImage.stretchableImage(withLeftCapWidth: Int(rainbowImage.size.width / 2), topCapHeight: 0)
            
        // Set the stretchable image as the track image
        colorSlider.setMinimumTrackImage(stretchableRainbowImage, for: .normal)
        colorSlider.setMaximumTrackImage(stretchableRainbowImage, for: .normal)
    }
    
    @IBAction func backgroundColorSliderChanged(_ sender: UISlider) {
        let hueValue = CGFloat(sender.value) // value is already between 0.0 and 1.0
            self.view.backgroundColor = UIColor(hue: hueValue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    }
    
    func generateRainbowImage(bounds: CGRect, trackHeight: CGFloat) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: trackHeight)
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor, UIColor.purple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        // Begin the image context with the new gradient layer bounds
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
        }
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        
        return gradientImage
    }
    
    @IBAction func textColorButtonChanged(_ sender: UIButton) {
        // Toggle the text color of all labels in the collection
        isTextWhite.toggle() // Toggle the boolean state
        let newColor: UIColor = isTextWhite ? .black : .white
        textLabels.forEach { $0.textColor = newColor }
    }
}
