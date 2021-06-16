import UIKit

protocol SearchResultSegementedControlDelegate: AnyObject {
    func change(to type: SearchResultPresenterType)
}

class SearchResultSegementedControl: UIView {
    private var buttonTypes: [SearchResultPresenterType] = SearchResultPresenterType.allCases
    private var buttons: [UIButton] = []
    private var selectedBottomView: UIView!
    private var selectedIndex: Int = 0

    var selectedViewColor: UIColor = .systemRed
    var selectedTextColor: UIColor = .systemRed
    var textColor: UIColor = .label

    weak var delegate: SearchResultSegementedControlDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Override

extension SearchResultSegementedControl {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
}

// MARK: - Public

extension SearchResultSegementedControl {
    func setType(_ type: SearchResultPresenterType) {
        if buttons.isEmpty { return }
        buttons.forEach { $0.setTitleColor(textColor, for: .normal) }
        let button = buttons[type.order]
        selectedIndex = type.order
        button.setTitleColor(selectedTextColor, for: .normal)
        updateSelectedPosition(type.order)
    }
}

// MARK: - Private

private extension SearchResultSegementedControl {
    func updateView() {
        configureButtons()
        configureBottomView()
        configureStackView()
    }

    func configureButtons() {
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        for type in SearchResultPresenterType.allCases {
            let button = UIButton(type: .system)
            button.setTitle(type.title, for: .normal)
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectedTextColor, for: .normal)
    }

    @objc func didTapButton(_ sender: UIButton) {
        for (index, button) in buttons.enumerated() {
            button.setTitleColor(textColor, for: .normal)
            if button == sender {
                updateSelectedPosition(index)
                button.setTitleColor(selectedTextColor, for: .normal)
            }
        }
    }

    func configureBottomView() {
        let selectorWidth = frame.width / CGFloat(buttonTypes.count)
        selectedBottomView = UIView(frame: CGRect(x: 0, y: frame.height, width: selectorWidth, height: 2))
        selectedBottomView.backgroundColor = selectedViewColor
        addSubview(selectedBottomView)
    }

    func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        let constraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func updateSelectedPosition(_ index: Int) {
        let position = frame.width / CGFloat(buttonTypes.count) * CGFloat(index)
        selectedIndex = index
        delegate?.change(to: buttonTypes[index])
        UIView.animate(withDuration: 0.3) {
            self.selectedBottomView.frame.origin.x = position
        }
    }
}
