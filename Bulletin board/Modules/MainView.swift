import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            Color(R.Colors.white).ignoresSafeArea(.all)
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
                
                title(title: response.result.title)
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(response.result.list
                            .prefix(2)
                            .indices, id: \.self) { index in
                                let item = response.result.list[index]
                                
                                Button(
                                    action: { viewModel.toggleSelection(for: item) },
                                    label: {
                                        HStack {
                                            iconImage(item)
                                            
                                            tableText(item)
                                            
                                            viewModel.marker(item: item)
                                        }
                                        .padding(.vertical, 15)
                                        .frame(maxWidth: .infinity)
                                        .background(Color(R.Colors.lightGray))
                                        .cornerRadius(10)
                                    }
                                )
                        }
                    }
                }
                .cornerRadius(10)
                .listStyle(.plain)
                .padding(.top, 40)
            } else {
                ProgressView()
            }
            chooseButton
        }
        .padding(.horizontal, 15)
    }
    
    func title(title: String) -> some View {
        Text(title)
            .customFont(SFProDisplay.bold, category: .extraExtraExtraLarge)
            .foregroundColor(Color(R.Colors.black))
            .lineSpacing(5)
            .padding(.top, 40)
    }
    
    @ViewBuilder
    func tableText(_ item: ListItem) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(item.title)
                .customFont(SFProDisplay.bold, category: .extraLarge)
                .foregroundColor(Color(R.Colors.black))
            Text(item.description ?? "")
                .customFont(SFProDisplay.medium, category: .medium)
                .multilineTextAlignment(.leading)
                .lineSpacing(4)
                .foregroundColor(Color(R.Colors.black))
            Text(item.price)
                .customFont(SFProDisplay.bold, category: .extraLarge)
                .foregroundColor(Color(R.Colors.black))
        }
    }
    
    func iconImage(_ item: ListItem) -> some View {
        AsyncImage(
            url: item.icon.the52X52
        ) { image in
        image.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 52, height: 52)
        } placeholder: {
            ProgressView()
        }
        .padding(.top, 10)
        .padding([.leading, .trailing], 20)
        .padding(.bottom, 90)
    }
}

// MARK: - Setup button

extension MainView {
    
    var dismissImage: some View {
        Image("cancel")
            .frame(width: 40, height: 40)
            .foregroundColor(Color(R.Colors.black))
            .background(Color(R.Colors.lightGray))
            .clipShape(Capsule())
            .padding(.top, 10)
    }
    
    var chooseButton: some View {
        Button(
            action: { viewModel.actionAlert() },
            label: { chooseText }
        )
        .padding([.top, .horizontal], 10)
        .padding(.bottom, 20)
    }
    
    var chooseText: some View {
        Text(R.MainView.chooseButton)
            .customFont(SFProDisplay.medium, category: .extraLarge)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 17)
            .background(Color(R.Colors.lightBlue))
            .foregroundColor(Color(R.Colors.white))
            .cornerRadius(10)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
