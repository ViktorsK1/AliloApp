//
//  GameView.swift
//  AliloApp
//
//  Created by Виктор Куля on 16.08.2022.
//

import UIKit

protocol GameViewDelegate: AnyObject {
    func didTapChangeMode()
    func didTapChangeMelody()
    func didCenteredOn(color: UIColor)
}

class GameView: UIView {
    
    // MARK: - Properties
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        return view
    }()
    private let rabbitView: RabbitView = {
        let customView = RabbitView()
        customView.backgroundColor = .clear
        return customView
    }()
    private let mainColorStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        return stack
    }()
    private let subColorStackView1: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    private let subColorStackView2: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    private let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    private let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    private let mintView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemMint
        return view
    }()
    private let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    private let purpleView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        return view
    }()
    private let brownView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    private let changeModeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Change mode", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.3833079338, green: 0.5841769576, blue: 0.8817983866, alpha: 1)
        return btn
    }()
    private let changeMelodyButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Change melody", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.2685433626, green: 0.5829296112, blue: 0.6224908233, alpha: 1)
        return btn
    }()
    
    private var colorViews: [UIView] {
        [redView, greenView, mintView, blueView, purpleView, brownView]
    }
    
    weak var delegate: GameViewDelegate?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
        setActionButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Actions
    private func setActionButton() {
        changeModeButton.addTarget(self, action: #selector(changeModePressed(_:)), for: .touchUpInside)
        changeMelodyButton.addTarget(self, action: #selector(changeMelodyPressed(_:)), for: .touchUpInside)
    }
    
    @objc
    private func changeModePressed(_ sender: UIButton) {
        delegate?.didTapChangeMode()
    }
    
    @objc
    private func changeMelodyPressed(_ sender: UIButton) {
        delegate?.didTapChangeMelody()
    }
    
    // MARK: - Helper methods
    private func initialSetup() {
        setupUI()
        makeConstraints()
        setRabbitPanGesture()
    }
    
    private func setupUI() {
        [mainView, mainColorStackView, buttonStackView, rabbitView].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        mainColorStackView.addArrangedSubview(subColorStackView1)
        mainColorStackView.addArrangedSubview(subColorStackView2)
        
        subColorStackView1.addArrangedSubview(redView)
        subColorStackView1.addArrangedSubview(greenView)
        subColorStackView1.addArrangedSubview(mintView)
        subColorStackView2.addArrangedSubview(blueView)
        subColorStackView2.addArrangedSubview(purpleView)
        subColorStackView2.addArrangedSubview(brownView)
        
        buttonStackView.addArrangedSubview(changeModeButton)
        buttonStackView.addArrangedSubview(changeMelodyButton)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            rabbitView.centerXAnchor.constraint(equalTo: mainColorStackView.centerXAnchor),
            rabbitView.centerYAnchor.constraint(equalTo: mainColorStackView.centerYAnchor),
            rabbitView.widthAnchor.constraint(equalToConstant: 100),
            rabbitView.heightAnchor.constraint(equalToConstant: 150)
        ])
        NSLayoutConstraint.activate([
            mainColorStackView.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainColorStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            mainColorStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
            mainColorStackView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.4)
        ])
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: mainColorStackView.bottomAnchor, constant: 150),
            buttonStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10)
        ])
    }
    
    // MARK: - PanGesture
    private func setRabbitPanGesture() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragRabbit(_:)))
        rabbitView.center = center
        rabbitView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func dragRabbit(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            print("Recognizer Began")
            
        case .changed:
            controlBorders()
            moveView(recognizer)
            
        case .ended, .cancelled:
            detectCenteredColor()
            controlBorders()
            
        default:
            break
        }
    }
    
    private func detectCenteredColor() {
        for view in colorViews {
            let point = CGPoint(x: rabbitView.frame.minX, y: rabbitView.frame.height / 2)
            let convertedCenter = rabbitView.convert(point, to: view)
            if view.frame.contains(convertedCenter) {
                delegate?.didCenteredOn(color: view.backgroundColor ?? .orange)
            }
        }
    }
    
    private func moveView(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: mainView)
        rabbitView.center = CGPoint(
            x: rabbitView.center.x + translation.x,
            y: rabbitView.center.y + translation.y
        )
        recognizer.setTranslation(CGPoint.zero, in: mainView)
    }
    
    private func controlBorders() {
        let bunnyView = rabbitView
        let mainStackView = mainColorStackView
        // mainStack x/y
        let mainStackMinX =  mainStackView.frame.minX
        let mainStackMinY =  mainStackView.frame.minY
        let mainStackMaxX =  mainStackView.frame.maxX
        let mainStackMaxY =  mainStackView.frame.maxY
        // bunny x/y
        let bunnyMinX =  rabbitView.frame.minX
        let bunnyMinY =  rabbitView.frame.minY
        let bunnyMaxX =  rabbitView.frame.maxX
        let bunnyMaxY =  rabbitView.frame.maxY
        // Restriction from above
        if bunnyMinY <= mainStackMinY {
            bunnyView.center.y = bunnyView.center.y + (mainStackMinY - bunnyMinY)
        }
        // Restriction on the left
        if bunnyMinX <= mainStackMinX {
            bunnyView.center.x = bunnyView.center.x + (mainStackMinX - bunnyMinX)
        }
        // Restriction to the right
        if bunnyMaxX >= mainStackMaxX {
            bunnyView.center.x = mainStackMaxX - (bunnyView.frame.width / 2)
        }
        // Restriction on the bottom
        if bunnyMaxY >= mainStackMaxY {
            bunnyView.center.y = mainStackMaxY - (bunnyView.frame.height / 2)
        }
    }
    
    func updateEarsColor(_ color: UIColor) {
        rabbitView.updateEarsColor(color)
    }
    
    func startEarsAnimation() {
        rabbitView.startEarsAnimation()
    }
    
    func stopEarsAnimation() {
        rabbitView.stopEarsAnimation()
    }
}
