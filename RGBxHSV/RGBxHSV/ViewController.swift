//
//  ViewController.swift
//  RGBxHSV
//
//  Created by Shinichi Hosomi on 2023/09/03.
//

import UIKit

class ViewController: UIViewController {
    private let rSlider = UISlider()
    private let gSlider = UISlider()
    private let bSlider = UISlider()
    private let hSlider = UISlider()
    private let sSlider = UISlider()
    private let vSlider = UISlider()
    
    private let rLabel = UILabel()
    private let gLabel = UILabel()
    private let bLabel = UILabel()
    private let hLabel = UILabel()
    private let sLabel = UILabel()
    private let vLabel = UILabel()
    
    private let titleLabel = UILabel()
        
    var hsv: HSVColor!
    var rgb: RGBColor!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rSlider.minimumValue = 0
        rSlider.maximumValue = 255
        rSlider.isContinuous = true
        rSlider.value = 0
        rSlider.addTarget(self, action: #selector(viewValueChanged), for: .valueChanged)
        rSlider.minimumTrackTintColor = .darkGray

        gSlider.minimumValue = 0
        gSlider.maximumValue = 255
        gSlider.isContinuous = true
        gSlider.value = 0
        gSlider.addTarget(self, action: #selector(viewValueChanged), for: .valueChanged)
        gSlider.minimumTrackTintColor = .darkGray

        bSlider.minimumValue = 0
        bSlider.maximumValue = 255
        bSlider.isContinuous = true
        bSlider.value = 0
        bSlider.addTarget(self, action: #selector(viewValueChanged), for: .valueChanged)
        bSlider.minimumTrackTintColor = .darkGray
        
        hSlider.minimumValue = 0
        hSlider.maximumValue = 360
        hSlider.isContinuous = true
        hSlider.value = 0
        hSlider.addTarget(self, action: #selector(viewValueChanged), for: .valueChanged)
        hSlider.minimumTrackTintColor = .darkGray

        sSlider.minimumValue = 0
        sSlider.maximumValue = 100
        sSlider.isContinuous = true
        sSlider.value = 0
        sSlider.addTarget(self, action: #selector(viewValueChanged), for: .valueChanged)
        sSlider.minimumTrackTintColor = .darkGray

        vSlider.minimumValue = 0
        vSlider.maximumValue = 100
        vSlider.isContinuous = true
        vSlider.value = 0
        vSlider.addTarget(self, action: #selector(viewValueChanged), for: .valueChanged)
        vSlider.minimumTrackTintColor = .darkGray
        
        rLabel.text = getTextWithSpace(label: "R", value: rSlider.value)
        rLabel.font = rLabel.font.withSize(20)
        rLabel.textColor = .red
        rLabel.backgroundColor = UIColor.gray.withAlphaComponent(1)
        rLabel.translatesAutoresizingMaskIntoConstraints = false
        rLabel.layer.masksToBounds = true
        rLabel.layer.cornerRadius = 8
        rLabel.numberOfLines = 1

        gLabel.text = getTextWithSpace(label: "G", value: gSlider.value)
        gLabel.font = gLabel.font.withSize(20)
        gLabel.textColor = .green
        gLabel.backgroundColor = UIColor.gray.withAlphaComponent(1)
        gLabel.translatesAutoresizingMaskIntoConstraints = false
        gLabel.layer.masksToBounds = true
        gLabel.layer.cornerRadius = 8
        gLabel.numberOfLines = 1

        bLabel.text = getTextWithSpace(label: "B", value: bSlider.value)
        bLabel.font = bLabel.font.withSize(20)
        bLabel.textColor = .blue
        bLabel.backgroundColor = UIColor.gray.withAlphaComponent(1)
        bLabel.translatesAutoresizingMaskIntoConstraints = false
        bLabel.layer.masksToBounds = true
        bLabel.layer.cornerRadius = 8
        bLabel.numberOfLines = 1

        hLabel.text = getTextWithSpace(label: "H", value: hSlider.value)
        hLabel.font = hLabel.font.withSize(20)
        hLabel.textColor = .white
        hLabel.backgroundColor = UIColor.gray.withAlphaComponent(1)
        hLabel.translatesAutoresizingMaskIntoConstraints = false
        hLabel.layer.masksToBounds = true
        hLabel.layer.cornerRadius = 8
        hLabel.numberOfLines = 1

        sLabel.text = getTextWithSpace(label: "S", value: hSlider.value)
        sLabel.font = sLabel.font.withSize(20)
        sLabel.textColor = .white
        sLabel.backgroundColor = UIColor.gray.withAlphaComponent(1)
        sLabel.translatesAutoresizingMaskIntoConstraints = false
        sLabel.layer.masksToBounds = true
        sLabel.layer.cornerRadius = 8
        sLabel.numberOfLines = 1

        vLabel.text = getTextWithSpace(label: "V", value: hSlider.value)
        vLabel.font = vLabel.font.withSize(20)
        vLabel.textColor = .white
        vLabel.backgroundColor = UIColor.gray.withAlphaComponent(1)
        vLabel.translatesAutoresizingMaskIntoConstraints = false
        vLabel.layer.masksToBounds = true
        vLabel.layer.cornerRadius = 8
        vLabel.numberOfLines = 1
        
        titleLabel.text = "                         RGB                     \n                            x\n                         HSV"
        titleLabel.textColor = .white
        //titleLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.layer.masksToBounds = true
        titleLabel.numberOfLines = 3
        
        let stackView = UIStackView(arrangedSubviews: [rLabel, rSlider, gLabel, gSlider, bLabel, bSlider, titleLabel, hLabel, hSlider, sLabel, sSlider, vLabel, vSlider])

        stackView.isHidden = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        //view.addSubview(textLabel)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
        ])
        
        rgb = RGBColor(R: rSlider.value, G: gSlider.value, B: bSlider.value)
        hsv = HSVColor(H: hSlider.value, S: sSlider.value, V: vSlider.value)

        hsv = RGB2HSV(rgb: rgb)
        updateView()
    }

    private func initColorAllSliders(){
        
        rSlider.thumbTintColor = .gray
        gSlider.thumbTintColor = .gray
        bSlider.thumbTintColor = .gray
        hSlider.thumbTintColor = .gray
        sSlider.thumbTintColor = .gray
        vSlider.thumbTintColor = .gray

    }
    
    @objc
    private func viewValueChanged(view: UIView) {
        switch view {
        case rSlider:
            rgb.R = rSlider.value
            hsv = RGB2HSV(rgb: rgb)
            initColorAllSliders()
            rSlider.thumbTintColor = .white
        case gSlider:
            rgb.G = gSlider.value
            hsv = RGB2HSV(rgb: rgb)
            initColorAllSliders()
            gSlider.thumbTintColor = .white
        case bSlider:
            rgb.B = bSlider.value
            hsv = RGB2HSV(rgb: rgb)
            initColorAllSliders()
            bSlider.thumbTintColor = .white
        case hSlider:
            hsv.H = hSlider.value
            rgb = HSV2RGB(hsv: hsv)
            initColorAllSliders()
            hSlider.thumbTintColor = .white
        case sSlider:
            hsv.S = sSlider.value
            rgb = HSV2RGB(hsv: hsv)
            initColorAllSliders()
            sSlider.thumbTintColor = .white
        case vSlider:
            hsv.V = vSlider.value
            rgb = HSV2RGB(hsv: hsv)
            initColorAllSliders()
            vSlider.thumbTintColor = .white
        default:
            break
        }
        
        updateView()

    }
    
    private func getTextWithSpace(label: String, value: Float) -> String {
        let leftSpace = "  "
        let rightSpace = "                 "
        let text = "\(leftSpace)\(label) : \(Int(value))\(rightSpace)"

        return text
    }

    private func updateView() {
        let red: CGFloat = CGFloat(rgb.R) / 255.0
        let green: CGFloat = CGFloat(rgb.G) / 255.0
        let blue: CGFloat = CGFloat(rgb.B) / 255.0
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        rSlider.value = rgb.R
        gSlider.value = rgb.G
        bSlider.value = rgb.B
        
        hSlider.value = hsv.H
        sSlider.value = hsv.S
        vSlider.value = hsv.V
        
        rLabel.text = getTextWithSpace(label: "R", value: rSlider.value)
        gLabel.text = getTextWithSpace(label: "G", value: gSlider.value)
        bLabel.text = getTextWithSpace(label: "B", value: bSlider.value)

        hLabel.text = getTextWithSpace(label: "H", value: hSlider.value)
        sLabel.text = getTextWithSpace(label: "S", value: sSlider.value)
        vLabel.text = getTextWithSpace(label: "V", value: vSlider.value)

    }
    
}


