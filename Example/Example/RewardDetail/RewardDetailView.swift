//
//  RewardDetailView.swift
//  Example
//
//  Created by David Bui on 24/03/2023.
//

import Kingfisher
import NimbleLoyalty
import SwiftUI

struct RewardDetailView: View {

    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: RewardDetailViewModel

    var body: some View {
        switch viewModel.state {
        case .idle:
            setUpView()
                .onAppear {
                    viewModel.loadRewardDetail()
                }
        case .loaded:
            setUpView()
        case .loading:
            setUpView(isLoading: true)
        case .redeemed:
            setUpView()
                .alert(isPresented: .constant(true)) {
                    Alert(
                        title: Text("Example"),
                        message: Text("Redeem reward successfully"),
                        dismissButton: Alert.Button.default(
                            Text("OK"),
                            action: {
                                viewModel.state = .loaded
                            }
                        )
                    )
                }
        case .redeeming:
            setUpView(isRedeeming: true)
        case let .error(message):
            setUpView()
                .alert(isPresented: .constant(true)) {
                    Alert(
                        title: Text("Example"),
                        message: Text(message),
                        dismissButton: Alert.Button.default(Text("OK"))
                    )
                }
        }
    }

    init(rewardCode: String) {
        _viewModel = StateObject(wrappedValue: RewardDetailViewModel(rewardCode: rewardCode))
    }

    private func setUpView(isLoading: Bool = false, isRedeeming: Bool = false) -> some View {
        VStack {
            ScrollView {
                if isLoading {
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Constants.Color.havelockBlue))
                            .frame(maxHeight: .infinity, alignment: .center)
                    }
                } else {
                    VStack(spacing: 20.0) {
                            KFImage(URL(string: viewModel.reward?.imageUrls?.first ?? ""))
                                .onFailureImage(UIImage(named: "logo"))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: UIScreen.main.bounds.height / 3)
                            .clipped()
                        VStack(spacing: 4.0) {
                            Text(viewModel.reward?.name ?? "")
                                .font(.system(size: 20.0))
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Constants.Color.mirageBlack)
                                .lineLimit(1)
                            Text("\(viewModel.reward?.pointCost ?? 0) Points")
                                .font(.system(size: 17.0))
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Constants.Color.chateauGreen)
                                .lineLimit(1)
                            Text("Until \(viewModel.reward?.expiresOn?.formatDate() ?? "")")
                                .font(.system(size: 15.0))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Constants.Color.mirageBlack)
                                .lineLimit(1)
                        }
                        .padding(.horizontal, 15.0)
                        Divider()
                            .frame(height: 1.0)
                            .background(Constants.Color.catskillWhite)
                            .padding(.horizontal, 15.0)
                        Text(viewModel.reward?.description ?? "")
                            .font(.system(size: 13.0))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Constants.Color.slateGray)
                            .padding(.horizontal, 15.0)
                        PrimaryButton(
                            isEnabled: .constant(true),
                            isLoading: isRedeeming,
                            action: {
                                viewModel.redeemReward()
                            },
                            title: "Redeem \(viewModel.reward?.pointCost ?? 0) Points",
                            height: 56.0
                        )
                        .frame(height: 56.0)
                        .padding(.bottom, 20.0)
                        .padding(.horizontal, 10.0)
                    }
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)
        .modifier(NavigationBackButtonModifier(action: {
            presentationMode.wrappedValue.dismiss()
        }))
    }
}

struct RewardDetailView_Previews: PreviewProvider {

    static var previews: some View {
        RewardDetailView(rewardCode: "code")
    }
}
