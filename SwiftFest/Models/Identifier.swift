struct Identifier<T>: Hashable, Codable {

    let value: String

    init(value: String) {
        self.value = value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        value = try container.decode(String.self)
    }

}

extension Identifier: ExpressibleByStringLiteral {
    init(extendedGraphemeClusterLiteral value: String) {
        self.value = value
    }
    init(stringLiteral value: String) {
        self.value = value
    }
    init(unicodeScalarLiteral value: String) {
        self.value = value
    }
}

extension Identifier: CustomStringConvertible {

    var description: String {
        return value
    }

}

protocol AnyIdentifiable {

}

protocol Identifiable: AnyIdentifiable {

    var id: Identifier<Self> { get }

}

struct AnyIdentifier: Hashable, Codable {

    let value: String

    init<T>(_ id: Identifier<T>) {
        value = String(describing: T.self) + id.value
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        value = try container.decode(String.self)
    }

}
