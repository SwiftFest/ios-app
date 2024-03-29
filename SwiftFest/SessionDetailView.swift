import BonMot
import Down
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
            $0.edges.equalTo(readableContentGuide)
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
            let down = Down(markdownString: sessionOutcome)
            if let xml = try? down.toHTML(.smart) {
                outcome = "\n<h2>Attendees can expect to learn</h2>\n<body>\(xml)</body>"
            } else {
                outcome = ""
            }
        } else {
            outcome = ""
        }

        let xml = """
        <h1>\(session.title)</h1>\(complexity)
        <body>\(session.description.components(separatedBy: "\n\n").joined(separator: "\n"))</body>\(outcome)
        """

        let baseStyle = StringStyle(
            .paragraphSpacingAfter(8)
        )

        let indent = UIFontMetrics.default.scaledValue(for: 10)
        let bulletString = NSAttributedString.composed(of: ["•", Tab.headIndent(indent)])

        let bold = StringStyle(.emphasis(.bold))
        let italic = StringStyle(.emphasis(.italic))
        
        let h1Style = StringStyle([
            .font(.systemFont(ofSize: 36, weight: .bold)),
            .adapt(.body),
            ])
        let bodyStyle = StringStyle([
            .font(.preferredFont(forTextStyle: .body)),
            ])
        let h2Style = StringStyle([
            .font(.systemFont(ofSize: 24, weight: .light)),
            .paragraphSpacingAfter(0),
            .adapt(.body),
            ])
        let labelStyle = StringStyle([
            .font(.preferredFont(forTextStyle: .body)),
            .emphasis(.bold),
            ])
        let valueStyle = StringStyle([
            .font(.preferredFont(forTextStyle: .body)),
            ])

        let style = StringStyle(
            .xmlRules([
                .style("h1", baseStyle.byAdding(stringStyle: h1Style)),
                .style("body", baseStyle.byAdding(stringStyle: bodyStyle)),
                .style("h2", baseStyle.byAdding(stringStyle: h2Style)),
                .style("label", baseStyle.byAdding(stringStyle: labelStyle)),
                .style("value", baseStyle.byAdding(stringStyle: valueStyle)),
                .style("code", StringStyle(
                    .color(Color.codeForeground.color),
                    .backgroundColor(Color.codeBackground.color),
                    .font(UIFont(name: "Menlo-Regular", size: UIFontMetrics.default.scaledValue(for: 17))!)
                    )),
                .style("del", StringStyle(
                    .strikethrough(.styleSingle, .black)
                    )),
                .style("em", italic),
                .style("i", italic),
                .style("bold", bold),
                .style("strong", bold),
                .enter(element: "li", insert: bulletString),
                ])
        )

        textView.attributedText = xml.styled(with: style)
    }

}
