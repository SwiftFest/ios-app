import BonMot
import SnapKit
import UIKit

class SessionDetailView: UIView {
    
    var session: Session? {
        didSet {
            guard let session = session else { return }
            update(session: session)
        }
    }

    private let textView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 8)
        textView.isEditable = false
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(textView)
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension SessionDetailView {

    func update(session: Session) {

        let complexity: String
        if let sessionComplexity = session.complexity {
            complexity = "\n<label>Complexity:</label> <value>\(sessionComplexity)</value>"
        } else {
            complexity = ""
        }

        let outcome: String
        if let sessionOutcome = session.outcome {
            outcome = "\n<h2>Attendees can expect to learn</h2>\n<body>\(sessionOutcome)</body>"
        } else {
            outcome = ""
        }

        let xml = """
<h1>\(session.title)</h1>\(complexity)
<body>\(session.description)</body>\(outcome)
"""

        let baseStyle = StringStyle(
            .paragraphSpacingAfter(4)
        )

        let style = StringStyle(
            .xmlRules([
                .style("h1", baseStyle.byAdding([
                    .font(.systemFont(ofSize: 36, weight: .bold)),
                    .adapt(.body),
                    ])),
                .style("body", baseStyle.byAdding([
                    .font(.preferredFont(forTextStyle: .body)),
                    ])),
                .style("h2", baseStyle.byAdding([
                    .font(.systemFont(ofSize: 24, weight: .light)),
                    .adapt(.body),
                    ])),
                .style("label", baseStyle.byAdding([
                    .font(.preferredFont(forTextStyle: .body)),
                    .emphasis(.bold),
                    ])),
                .style("value", baseStyle.byAdding([
                    .font(.preferredFont(forTextStyle: .body)),
                    ])),
                ])
        )

        textView.attributedText = xml.styled(with: style)
    }

}
