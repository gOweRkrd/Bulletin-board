import SwiftUI

// MARK: - Response
struct Response: Codable {
    let status: String
    var result: Result
}

// MARK: - Result
struct Result: Codable {
    let title, actionTitle, selectedActionTitle: String
    var list: [ListItem]
}

// MARK: - ListItem
struct ListItem: Codable {
    let id, title: String
    let description: String?
    let icon: Icon
    let price: String
    var isSelected: Bool
}

// MARK: - Icon
struct Icon: Codable {
    let the52X52: URL 

    enum CodingKeys: String, CodingKey {
        case the52X52 = "52x52"
    }
}
