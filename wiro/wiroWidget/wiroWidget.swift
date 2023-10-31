//
//  wiroWidget.swift
//  wiroWidget
//
//  Created by 박준하 on 10/31/23.
//

import WidgetKit
import SwiftUI

let quotes = ["원하는 대로 끄적이다 보면\n바라는 대로 이루어질 거야.", "그냥 만족하면서 살아\n남이 가진 거 부러워하지 말고", "지나친 걱정은 몸과 마음을 해칠 뿐이야","매일 좋을순 없지만\n매일 웃을순 있지", "잘했어, 우리", "그대 정말 사랑했다 말해요","내가 너라면 그냥 날 사랑할 텐데", "복잡해 분명 행복 바랬어\n이렇게 빨리 보고 싶을 줄", "그댈 추억하기보단 기다리는 게\n부서진 내 마음이 더 아파와","빛나는 오늘 함께 하는 우리\n모든 게 선물인걸", "너를 안아 사랑을 담아\n행복이라고 예쁘게 적어본다.", "바람처럼 사라질까 내 마음을 채워줄까","이대로 너와 내 시간이 멈춰버렸음 해", "너를 떠나보낼 준비해둘걸 그랬어", "나랑 있으면 어떤 불편도 괜찮은 줄만 알았어","가끔 나쁜 얼굴에 각진 단어를 골라", "쓰다 남은 위로라면 그냥 지나가도 돼", "난 너에게 너무 앞서가던 한 사람","후회 없이 꿈을 꾸었다 말해요!", "나를 사랑하는 사람에 이젠 곁에 없지만", "내가 아니라도 눈부시게 사랑받았을 너라서","지금처럼 곁에 있어주면 돼 언제나", "어떻게 이별까지 사랑하겠어, 널 사랑하는 거지", "추억은 만남보다 이별의 남아\n여전히 너를 사랑하고 있나봐 그날처럼","사실은 포기가 더 쉬워보이긴해"]

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        let quote = quotes.isEmpty ? "" : quotes[0]
        return SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), quote: quote)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        let quote = quotes.isEmpty ? "" : quotes[0]
        return SimpleEntry(date: Date(), configuration: configuration, quote: quote)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for secondOffset in 0 ..< 50 {
            let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset * 10, to: currentDate)!
            let quote = quotes[secondOffset % quotes.count]
            let entry = SimpleEntry(date: entryDate, configuration: configuration, quote: quote)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let quote: String
}

struct wiroWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.quote)
        }
        .background {
            Image("TestBackgroound")
        }
    }
}

struct wiroWidget: Widget {
    let kind: String = "wiroWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            wiroWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    wiroWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley, quote: quotes.isEmpty ? "" : quotes[0])
        SimpleEntry(date: .now, configuration: .starEyes, quote: quotes.count > 1 ? quotes[1] : "")
}
