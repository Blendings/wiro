//
//  wiroWidgetLiveActivity.swift
//  wiroWidget
//
//  Created by 박준하 on 10/31/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct wiroWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct wiroWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: wiroWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension wiroWidgetAttributes {
    fileprivate static var preview: wiroWidgetAttributes {
        wiroWidgetAttributes(name: "World")
    }
}

extension wiroWidgetAttributes.ContentState {
    fileprivate static var smiley: wiroWidgetAttributes.ContentState {
        wiroWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: wiroWidgetAttributes.ContentState {
         wiroWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: wiroWidgetAttributes.preview) {
   wiroWidgetLiveActivity()
} contentStates: {
    wiroWidgetAttributes.ContentState.smiley
    wiroWidgetAttributes.ContentState.starEyes
}
