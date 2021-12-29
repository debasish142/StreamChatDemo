//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import Combine
import StreamChat
import SwiftUI

/// Handles the unmute command.
public class UnmuteCommandHandler: TwoStepMentionCommand {
    
    @Injected(\.images) private var images
    @Injected(\.chatClient) private var chatClient
                        
    init(
        channelController: ChatChannelController,
        commandSymbol: String,
        id: String = "/unmute"
    ) {
        super.init(
            channelController: channelController,
            commandSymbol: commandSymbol,
            id: id
        )
        let displayInfo = CommandDisplayInfo(
            displayName: "Unmute",
            icon: images.commandUnmute,
            format: "\(id) [@username]",
            isInstant: true
        )
        self.displayInfo = displayInfo
    }

    override public func executeOnMessageSent(
        composerCommand: ComposerCommand,
        completion: @escaping (Error?) -> Void
    ) {
        if let mutedUser = selectedUser {
            chatClient
                .userController(userId: mutedUser.id)
                .unmute { [weak self] error in
                    self?.selectedUser = nil
                    completion(error)
                }

            return
        }
    }
}