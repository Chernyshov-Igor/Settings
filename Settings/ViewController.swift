import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Настройки"

        view.addSubview(tableView)
    }
// По хорошему было использовать enum для всех string, но делал чтобы быстрее
    let bigData: [[(name: String,
                    secondaryText: String?,
                    systemImage: String,
                    accesoryType: UITableViewCell.AccessoryType,
                    switchView: Bool)]] = [
                   [("Авиарежим", nil, "airplane", .none, true),
                    ("Wi-Fi", nil, "wifi", .disclosureIndicator, false),
                    ("Bluetooth", "Вкл.", "b.circle.fill", .disclosureIndicator, false),
                    ("Сотовая связь", nil, "antenna.radiowaves.left.and.right", .disclosureIndicator, false),
                    ("Режим модема", nil, "personalhotspot", .disclosureIndicator, false),
                    ("VPN", "Не подключено", "bonjour", .disclosureIndicator, true)],

                   [("Уведомления", nil, "bell", .disclosureIndicator, false),
                    ("Звуки, тактильные сигналы", nil, "speaker", .disclosureIndicator, false),
                    ("Фокусирование", nil, "moon", .disclosureIndicator, false),
                    ("Экранное время", nil, "stopwatch", .disclosureIndicator, false)],

                   [("Основные", nil, "gear", .disclosureIndicator, false),
                    ("Пункт управления", nil, "switch.2", .disclosureIndicator, false),
                    ("Экран и яркость", nil, "textformat.size", .disclosureIndicator, false),
                    ("Экран \"Домой\"", nil, "tv", .disclosureIndicator, false),
                    ("Универсальный доступ", nil, "folder.badge.person.crop", .disclosureIndicator, false),
                    ("Обои", nil, "photo", .disclosureIndicator, false),
                    ("Siri и поиск", nil, "magnifyingglass", .disclosureIndicator, false),
                    ("Face ID и код-пароль", nil, "faceid", .disclosureIndicator, false)]]

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    @objc func switchChanged(_ sender : UISwitch?){
        if let sender = sender {
            print("""
                  Нажат переключатель ячейки \(String(describing: sender.accessibilityIdentifier)) \
                  в положение \(sender.isOn ? "ВКЛ." : "ВЫКЛ.")
                  """)
        }
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

        // Image
        content.image = UIImage(systemName: bigData[indexPath.section][indexPath.row].systemImage)

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
