import SnapKit

class CircleView: UIView {

    init() {
        super.init(frame: .zero)
        sharedSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedSetup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height / 2
    }

}

private extension CircleView {

    func sharedSetup() {
        layer.masksToBounds = true
        clipsToBounds = true
        snp.makeConstraints { make in
            make.width.equalTo(snp.height)
        }
    }

}
