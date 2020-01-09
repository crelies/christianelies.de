import Publish
import SplashPublishPlugin

try PersonalWebsite().publish(using: [
    .installPlugin(.splash(withClassPrefix: "")),
    .addSectionTitles(),
    .copyResources(),
    .copyFiles(at: "Styles", to: "css"),
    .copyFiles(at: "webfonts", includingFolder: true),
    .addMarkdownFiles(),
    .sortItems(by: \.date, order: .descending),
    .installPlugin(.ensureAllItemsAreTagged),
    .insertPostDates(),
    .insertPostTags(),
    .insertPostTitles(),
    .generateHTML(withTheme: .personal),
    .generateRSSFeed(including: Set(PersonalWebsite.SectionID.allCases),
                     config: .default),
    .generateSiteMap(),
    .deploy(using: .gitHub("crelies/christianelies.de"))
])
