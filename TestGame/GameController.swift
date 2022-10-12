//
//  GameController.swift
//  TestGame
//
//  Created by user on 10.08.2022.
//

import UIKit

class GameController: UIViewController {
  
 
    @IBOutlet var buttons: [UIButton]!                // IBOutlet нам нужен для изменения свойств
                 
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
                                                      // Создаем экземпляр для нашей модели
    @IBOutlet weak var timerLabel: UILabel!
    
    
    lazy var game = Game(countItems: buttons.count, time: 30) { [weak self] (status, time) in
        guard let self = self else {return}
        self.timerLabel.text = "\(time)"
    }
    
    // Lazy  позволяет инициализировать переменную в тот момент когда она                                                  потребуется
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        
    }
    
    @IBAction func pressButton(_ sender: UIButton) {     // IBAction нам нужен для обработки нажатий, изменения действий
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}     //(будущее) делаем проверку кнопки которая                                                                       нажата, получаем индекс через горд
        game.check(index:buttonIndex)     //обращаемся к нашей модели куда будем передавать индекс
        
        updateUI()
                                // isHidden - свойство скрывающее кнопку при нажатии
            }
    
    private func setupScreen(){                          // Настройка экрана, в этой функции наша задача пробежаться по                                                        массиву items и просвоить всем buttoms в нашем view нужные свойства                                                   а именно titlle и задать видимость
    
        
        for index in game.items.indices{                 // Чтобы связать массив данных из модели с массивом view мы                                                  пробежимся по индексам айтемов
            
            
            
            buttons[index].setTitle(game.items[index].tittle, for: .normal)         // сменили цифру на кнопке
            buttons[index].isHidden = false                                         // чтобы все кнопки были видны(например                                                                       если новая игра)
        
        }
        
        nextDigit.text = game.nextItem?.tittle     //в некстдиджит помещаем некст айтем и появляется число в лейбл
        
        
        
        
    }
    
    private func updateUI() {                                     //функция будет обновлять наш экран
        for index in game.items.indices{                          //пробегаемся по индексам и айтемам
            buttons[index].isHidden = game.items[index].isFound   //по индексу достаем все кнопки и будем скрывать их с                                                         экрана в том случае если нажал правильно
        }
        nextDigit.text = game.nextItem?.tittle
        
        if game.status == .win{
            statusLabel.text = "Ti pidor"
            statusLabel.textColor = .green
            
        }
    }
    
    private func updateInfoGame(with status:StatusGame){
        switch status   {
        case .start :
            statusLabel
        case .win :
            
        case .lose :
            <#code#>
        default:
            <#code#>
        }
    }
}
