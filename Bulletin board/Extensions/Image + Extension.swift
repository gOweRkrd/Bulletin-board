import SwiftUI

extension Image {
    func data(url: URL?) -> Self {
        guard let url = url else {
            return self
        }
        if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            return Image(uiImage: image)
        }
        return self
    }
}
