//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import NukeUI
import StreamChat
import SwiftUI

public struct MessageAvatarView: View {
    @Injected(\.utils) var utils
    @Injected(\.colors) var colors
    
    private var imageCDN: ImageCDN {
        utils.imageCDN
    }
    
    var author: ChatUser
    var size: CGSize
    
    public init(author: ChatUser, size: CGSize = CGSize.messageAvatarSize) {
        self.author = author
        self.size = size
    }
    
    public var body: some View {
        if let urlString = author.imageURL?.absoluteString, let url = URL(string: urlString) {
            let adjustedURL = imageCDN.thumbnailURL(
                originalURL: url,
                preferredSize: size
            )
            
            LazyImage(source: adjustedURL)
                .onDisappear(.reset)
                .clipShape(Circle())
                .frame(
                    width: size.width,
                    height: size.height
                )
            
        } else {
            Image(systemName: "person.circle")
                .renderingMode(.template)
                .resizable()
                .foregroundColor(Color(colors.textLowEmphasis))
                .frame(
                    width: size.width,
                    height: size.height
                )
        }
    }
}

extension CGSize {
    public static var messageAvatarSize = CGSize(width: 36, height: 36)
}