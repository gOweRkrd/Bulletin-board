import SwiftUI

final class MainViewModel: ObservableObject {
    
    @Published var response: Response?
    @Published var selectedIndex: Int?
        
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
            if let selectedIndex = selectedIndex, selectedIndex != index {
                response?.result.list[selectedIndex].isSelected = false
            }
            response?.result.list[index].isSelected.toggle()
            selectedIndex = index
        }
    }
    
    func marker(item: ListItem) -> some View {
        Image(systemName: item.isSelected ? "checkmark.circle.fill" : "")
            .font(.system(size: 30))
            .foregroundColor(item.isSelected ? Color(R.Colors.lightBlue) : nil)
            .padding(.leading, 10)
            .padding(.trailing, 20)
            .padding(.bottom, 110)
    }
}

// MARK: - Setup alert

extension MainViewModel {
    
    func actionAlert() {
        let selectedItems = response?.result.list.filter { $0.isSelected }
        let selectedTitles = selectedItems?.map { $0.title } ?? []
        let alertMessage = selectedTitles.joined(separator: ", ")
        showAlert(message: alertMessage)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Выбранные услуги", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }
}
