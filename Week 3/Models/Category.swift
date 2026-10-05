import Foundation

struct Category: Identifiable, Hashable, Codable {
    let id: UUID
    var name: String
    var iconName: String
    
    init(id: UUID = UUID(), name: String, iconName: String) {
        self.id = id
        self.name = name
        self.iconName = iconName
    }
}
