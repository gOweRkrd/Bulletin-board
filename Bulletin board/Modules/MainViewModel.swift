import SwiftUI

final class ViewModel: ObservableObject {
    
    @Published var response: Response?
        
    func fetchData() {
        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                self.response = response
            } catch {
                print("Ошибка при загрузке данных JSON: \(error)")
            }
        }
    }
    
    func toggleSelection(for item: ListItem) {
        if let index = response?.result.list.firstIndex(where: { $0.id == item.id }) {
            response?.result.list[index].isSelected.toggle()
        }
    }
}
