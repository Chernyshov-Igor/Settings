import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Настройки"

        view.addSubview(tableView)
    }

    let bigData: [[(name: String,
                    accesoryType: UITableViewCell.AccessoryType,
                    switchView: Bool)]] = [
                   [("Авиарежим", .none, true),
                    ("Wi-Fi", .disclosureIndicator, false),
                    ("Bluetooth", .disclosureIndicator, false),
                    ("Сотовая связь", .disclosureIndicator, false),
                    ("Режим модема", .disclosureIndicator, false),
                    ("VPN", .disclosureIndicator, true)],

                   [("Уведомления", .disclosureIndicator, false),
                    ("Звуки, тактильные сигналы", .disclosureIndicator, false),
                    ("Фокусирование", .disclosureIndicator, false),
                    ("Экранное время", .disclosureIndicator, false)],

                   [("Основные", .disclosureIndicator, false),
                    ("Пункт управления", .disclosureIndicator, false),
                    ("Экран и яркость", .disclosureIndicator, false),
                    ("Экран \"Домой\"", .disclosureIndicator, false),
                    ("Универсальный доступ", .disclosureIndicator, false),
                    ("Обои", .disclosureIndicator, false),
                    ("Siri и поиск", .disclosureIndicator, false),
                    ("Face ID и код-пароль", .disclosureIndicator, false)]]

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    @objc func switchChanged(_ sender : UISwitch!){
        print("Нажат переключатель ячейки \(sender.accessibilityIdentifier)")
        print("Переключатель \(sender.isOn ? "ВКЛ." : "ВЫКЛ.")")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

//    MARK: Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let dataContent = bigData[indexPath.section][indexPath.row]
        print("Нажата ячейка \(dataContent.name)")
    }

//    MARK: DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return bigData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bigData[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let dataContent = bigData[indexPath.section][indexPath.row]
        content.text = dataContent.name
        cell.accessoryType = dataContent.accesoryType
        cell.contentConfiguration = content

        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        switchView.accessibilityIdentifier = dataContent.name
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)

        if dataContent.switchView {
            cell.accessoryView = switchView
        } else {
            cell.accessoryView = nil
        }

        return cell
    }

}
