import UIKit

class ViewController: UIViewController {
    typealias CellType = (name: String, accesoryType: UITableViewCell.AccessoryType)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Настройки"

        view.addSubview(tableView)
    }

    let dataCell: [CellType] = [("Test1", .none), ("Test2", .disclosureIndicator), ("Test3", .none)]

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

//    Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let dataContent = dataCell[indexPath.row]
        print("Нажата ячейка \(dataContent.name)")
    }

//    DataSource
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//            case 0:
//                return 6
//            case 1:
//                return 4
//            case 2:
//                return 10
//            default:
//                return 0
//        }
        return dataCell.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let dataContent = dataCell[indexPath.row]
        content.text = dataContent.name
        cell.accessoryType = dataContent.accesoryType
        cell.contentConfiguration = content

        return cell
    }

}
