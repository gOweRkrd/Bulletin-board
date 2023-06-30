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
                
                List(response.result.list.prefix(2), id: \.id) { item in
                    HStack {
                        AsyncImage(url: item.icon.the52X52) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 52, height: 52)
                        } placeholder: {
                            ProgressView()
                        }
                        .padding(.top, 10)
                        .padding(.trailing, 20)
                        .padding(.bottom, 80)

                        VStack(alignment: .leading, spacing: 10) {
                            Text(item.title)
                                .font(.headline)
                            Text(item.description ?? "")
                                .font(.subheadline)
                            Text(item.price)
                                .font(.headline)
                        }
                    }
                    .padding(.vertical, 15)
                    .padding(.trailing, 10)
                    .padding(.trailing, 20)
                    .listRowBackground(Color(R.Colors.lightGray))
                }
                .cornerRadius(10)
                .padding(.top, 40)
                .listStyle(.plain)
            } else {
                ProgressView()
            }
            chooseButton
                .padding(.bottom, 20)
        }
        .padding(.horizontal, 15)
    }
    
    var dismissImage: some View {
        Image("cancel")
            .foregroundColor(.black)
            .padding(.top, 10)
    }
}

// MARK: - Setup button

extension MainView {
    var chooseButton: some View {
        Button(
            action: { },
            label: { chooseText }
        )
        .padding(.top, 10)
        .padding(.horizontal, 10)
    }
    
    var chooseText: some View {
        Text("Выбрать")
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.top, 17)
            .padding(.bottom, 17)
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
