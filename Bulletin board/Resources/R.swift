import SwiftUI

enum StringResources {
    
    enum NetworkManager {
        static let invalidUrl = "Invalid URL"
        static let invalidResponse = "Invalid response"
        static let statusCode = "Unexpected status code:"
    }
    
    enum Colors {
        static let white = UIColor(hexString: "#FFFFFF")
        static let black = UIColor(hexString: "#000000")
        static let lightGray = UIColor(hexString: "#F8F8F8")
    }
}

typealias R = StringResources
