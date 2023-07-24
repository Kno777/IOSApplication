import UIKit

class TodoTableViewCell: UITableViewCell {
    
    var todo: ToDo? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var lable1: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var lable2: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(lable1)
        addSubview(lable2)
        
        NSLayoutConstraint.activate([
            lable1.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            lable2.topAnchor.constraint(equalTo: lable1.topAnchor, constant: 20),
            lable2.leadingAnchor.constraint(equalTo: lable1.leadingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func updateUI() {
        guard let todo = todo else {
            lable1.text = ""
            lable2.text = ""
            return
        }
        
        lable1.text = todo.title
        lable2.text = todo.description
    }
}
