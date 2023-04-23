//
//  ContentViewModel.swift
//  MyRxSampleApp
//
//  Created by Eugene Gordenstein on 20/02/2023.
//

import Foundation
import MyRxSDK
import SwiftUI

enum ViewState {
    case controls
    case myRx
}

class ContentViewModel: ObservableObject {
    @Published var viewState: ViewState = .controls

    @Published var myRxView: any View = EmptyView()

    func initialize() {
        DispatchQueue.global().async {
            Task {
                do {
                    try await MyRx.initialize(delegate: self,
                                              clientID: "Paste Client ID Here",
                                              profileName: "Paste Profile Name Here",
                                              region: .staging,
                                              showOnboarding: true,
                                              userInterfaceConfiguration: MyRxUIConfiguration(fontFamily: "Lexend"))
                    self.logMessage("Initialize finished successfully")
                } catch {
                    self.logMessage("Initialize failed with error: \(error) - \(error.localizedDescription)")
                }
            }
        }
    }

    func start() {
        Task {
            do {
                let view = try await startAndGetMyRxView()
                logMessage("Start finished successfully")
                DispatchQueue.main.async {
                    self.myRxView = view
                    self.viewState = .myRx
                }
            } catch {
                self.logMessage("Open failed with error: \(error) - \(error.localizedDescription)")
            }
        }
    }

    private func startAndGetMyRxView() async throws -> any View {
        let view = try await MyRx.startAndGetRootView(withFlow: "eyes")
        return view
    }

    func close() {
        MyRx.close()
        logMessage("Closed")
        openControls()
    }

    func sessionID() {
        logMessage(MyRx.getSessionID())
    }

    func userID() {
        logMessage(MyRx.getUserID())
    }

    func isInitialized() {
        logMessage("\(MyRx.isInitialized)")
    }

    func isOpen() {
        logMessage("\(MyRx.didStart)")
    }

    private func openControls() {
        DispatchQueue.main.async {
            self.viewState = .controls
        }
    }

    private func logMessage(_ message: String, function: String = #function) {
        let logMessage = """
            🍣 \(function) output:
            ----------------------------
            \(message)
            ----------------------------
            """
        print(logMessage)
    }
}

extension ContentViewModel: MyRxDelegate {
    
    func receivedLunaID(lunaID: String) {
        logMessage("receivedLunaID")

    }
    
    func onClose(reason: MyRxCloseReason) {
        logMessage("SDK was closed with reason: \(reason)")
        openControls()
    }

    func onCompletion() {
        logMessage("onCompletion")
        MyRx.close()
    }

    func userNeedsSupport() {
        logMessage("userNeedsSupport")
    }

    func onMedicalError() {
        logMessage("onMedicalError")
        MyRx.close()
    }
}
