//
//  WidgetHero.swift
//  WidgetHero
//
//  Created by Mehmet Jiyan Atalay on 19.03.2024.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    
    @AppStorage("hero",store: UserDefaults(suiteName: "group.com.jiyanatalay.HeroWidget"))
    var heroData : Data = Data()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), hero: Superhero(name: "Batman", realName: "Bruce Wayne", image: "batman"))
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        
        if let hero = try? JSONDecoder().decode(Superhero.self, from: heroData) {
            return SimpleEntry(date: Date(), configuration: configuration, hero: hero)
        }
        //SimpleEntry(date: Date(), configuration: configuration, hero: <#Superhero#>)
        return SimpleEntry(date: Date(), configuration: configuration, hero: Superhero(name: "Batman", realName: "Bruce Wayne", image: "batman"))

    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        if let hero = try? JSONDecoder().decode(Superhero.self, from: heroData) {
            let entry = SimpleEntry(date: Date(), configuration: configuration, hero: hero)
            let timeline = Timeline(entries: [entry], policy: .never)
            return timeline
        }
        return Timeline(entries: [SimpleEntry(date: Date(), configuration: configuration, hero: Superhero(name: "Batman", realName: "Bruce Wayne", image: "batman"))], policy: .never)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let hero : Superhero
}

struct WidgetHeroEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        CircularImageView(image: Image(entry.hero.image))
    }
}

struct WidgetHero: Widget {
    let kind: String = "WidgetHero"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WidgetHeroEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }.configurationDisplayName("Widget Hero")
            .description("Hero Widget!!!")
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
