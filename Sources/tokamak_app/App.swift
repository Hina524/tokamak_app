import TokamakDOM
import tokamak_appLibrary
import JavaScriptKit

private let jsFetch = JSObject.global.fetch.function!
func fetch(_ url: String) -> JSPromise {
    let options: [String: ConvertibleToJSValue] = ["mode": "cors"]
    return JSPromise(jsFetch(url, options.jsValue).object!)!
}

@main
struct TokamakApp: App {
    var body: some Scene {
        WindowGroup("Tokamak App") {
            ContentView()
        }
    }
}

struct Item {
    var isCompleted: Bool = false
    var text: String
}

struct ContentView: View {
    @State var newItem = ""
    @State var items = [Item]()

    func addNewItem() {
        jsFetch("http://localhost:8080/todos")
        items.append(Item(text: newItem))
        newItem = ""
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button("+", action: addNewItem)
                TextField("New todo item", text: $newItem, onCommit: addNewItem)
            }
            List {
                ForEach(0..<items.count, id: \.self) { i in
                        Toggle(
                            items[i].text,
                            isOn: Binding(get: { items[i].isCompleted }, set: { items[i].isCompleted = $0 })
                        )
                }
            }
        }
    }
}

// struct ContentView: View {
//     var body: some View {
//         Text("Hello, world!")
//     }
// }
