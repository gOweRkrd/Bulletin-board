import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
            content
                .onAppear {
                    viewModel.fetchData()
                }
        }
    }
}

// MARK: - Content

extension MainView {
    
    var content: some View {
        VStack(alignment: .leading) {
            if let response = viewModel.response {
                dismissImage
                Text(response.result.title)
                    .font(.title)
                    .lineSpacing(5)
                    .padding(.top, 40)
                
                List(response.result.list, id: \.id) { item in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(item.title)
                            .font(.headline)
                        Text(item.description ?? "")
                            .font(.subheadline)
                        Text(item.price)
                            .font(.headline)
                    }
                    .padding(.vertical, 15)
                    .padding([.leading, .trailing], 50)
                    .listRowBackground(Color(R.Colors.lightGray))
                }
                .cornerRadius(10)
                .padding(.top, 40)
                .listStyle(.plain)
            } else {
                Text("Loading...")
            }
        }
        .padding(.horizontal, 15)
    }
    
    var dismissImage: some View {
        Image("cancel")
            .foregroundColor(.black)
            .padding(.top, 10)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}