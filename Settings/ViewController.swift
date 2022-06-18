import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Настройки"

        view.addSubview(tableView)
    }

    var bigData: [[(name: String,
                    secondaryText: String?,
                    accesoryType: UITableViewCell.AccessoryType,
                    switchView: Bool)]] = [
                   [("Авиарежим", nil, .none, true),
                    ("Wi-Fi", nil, .disclosureIndicator, false),
                    ("Bluetooth", "Вкл.", .disclosureIndicator, false),
                    ("Сотовая связь", nil, .disclosureIndicator, false),
                    ("Режим модема", nil, .disclosureIndicator, false),
                    ("VPN", "Не подключено", .disclosureIndicator, true)],

                   [("Уведомления", nil, .disclosureIndicator, false),
                    ("Звуки, тактильные сигналы", nil, .disclosureIndicator, false),
                    ("Фокусирование", nil, .disclosureIndicator, false),
                    ("Экранное время", nil, .disclosureIndicator, false)],

                   [("Основные", nil, .disclosureIndicator, false),
                    ("Пункт управления", nil, .disclosureIndicator, false),
                    ("Экран и яркость", nil, .disclosureIndicator, false),
                    ("Экран \"Домой\"", nil, .disclosureIndicator, false),
                    ("Универсальный доступ", nil, .disclosureIndicator, false),
                    ("Обои", nil, .disclosureIndicator, false),
                    ("Siri и поиск", nil, .disclosureIndicator, false),
                    ("Face ID и код-пароль", nil, .disclosureIndicator, false)]]

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

        // Secondary text
        content.prefersSideBySideTextAndSecondaryText = true
        content.secondaryTextProperties.font = .systemFont(ofSize: 18)
        content.secondaryTextProperties.color = .gray
        content.secondaryText = bigData[indexPath.section][indexPath.row].secondaryText

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
