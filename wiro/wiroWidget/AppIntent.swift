//
//  AppIntent.swift
//  wiroWidget
//
//  Created by 박준하 on 10/31/23.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "오늘의 기분은 어떤신가요?", default: "🫠")
    var favoriteEmoji: String
}
