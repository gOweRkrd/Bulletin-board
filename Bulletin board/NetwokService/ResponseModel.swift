import SwiftUI

// MARK: - Response
struct Response: Decodable {
    let status: String
    var result: Result
}

// MARK: - Result
struct Result: Decodable {
    let title, actionTitle, selectedActionTitle: String
    var list: [ListItem]
}

// MARK: - ListItem
struct ListItem: Decodable {
    let id, title: String
    let description: String?
    let icon: Icon
    let price: String
    var isSelected: Bool
}

// MARK: - Icon
struct Icon: Decodable {
    let the52X52: URL 

    enum CodingKeys: String, CodingKey {
        case the52X52 = "52x52"
    }
}
