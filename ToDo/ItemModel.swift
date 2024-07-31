import Foundation

struct ItemModel: Identifiable, Equatable {
    var title: String
    var isComplited: Bool = false
    var id: UUID = UUID()
    var state: String = ""
}
