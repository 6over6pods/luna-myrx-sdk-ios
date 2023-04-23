//
//  ContentView.swift
//  MyRxSampleApp
//
//  Created by Eugene Gordenstein on 20/02/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        switch viewModel.viewState {
        case .myRx:
            AnyView(viewModel.myRxView)
        case .controls:
            Form {
                Section {
                    Button("Init",
                           action: viewModel.initialize)

                    Button("Start",
                           action: viewModel.start)

                    Button("Close",
                           action: viewModel.close)

                    Button("Session ID",
                           action: viewModel.sessionID)

                    Button("User ID",
                           action: viewModel.userID)

                    Button("Is Initialized",
                           action: viewModel.isInitialized)

                    Button("Is Open",
                           action: viewModel.isOpen)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
