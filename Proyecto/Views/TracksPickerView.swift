//
//  TracksPickerView.swift
//  Proyecto
//
//  Created by Sofia Condomi on 29/11/2021.
//

import UIKit



class TracksPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    var delegadodos:TracksPickerDelegate?
    let UIPicker: UIPickerView = UIPickerView()
    let TableView: UITableView = UITableView()
    
    // Llenado del picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return misTracks.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            let rowStr = misTracks[row]
            return rowStr.title
        }

    
    // Seteo de objetos:
    
    var BotonDismiss: UIButton = {
        let b1 = UIButton(type: .roundedRect)
        let b1Image = UIImage(named: "dismiss")
        b1.setImage(b1Image, for: .normal)
        b1.autoresizingMask = .flexibleWidth
        //b1.translatesAutoresizingMaskIntoConstraints=true
        b1.translatesAutoresizingMaskIntoConstraints=false
        b1.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return b1
    }()
    
    @objc func dismiss() {
        self.removeFromSuperview()
    }
    
    var Botonadd: UIButton = {
        let b1 = UIButton(type: .roundedRect)
        let b1Image = UIImage(named: "add.png")
        b1.setImage(b1Image, for: .normal)
        b1.autoresizingMask = .flexibleWidth
        b1.translatesAutoresizingMaskIntoConstraints=true
        b1.addTarget(self, action: #selector(add), for: .touchUpInside)
        return b1
    }()
    
    @objc func add() {
            if delegadodos != nil {
                let index = UIPicker.selectedRow(inComponent: 0)
                let track = misTracks[index]
                print(track)
                delegadodos?.addTrack(track: track)
        }
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            self.backgroundColor = .clear
          }
    
    // Dibujar objetos en la vista
    override func draw(_ rect: CGRect) {
        
        TableView.backgroundColor = .clear
        UIPicker.frame = CGRect(x: 0, y: 30, width: rect.width, height: rect.height-30)
        UIPicker.delegate = self
        UIPicker.dataSource = self
        UIPicker.backgroundColor = .clear
        UIPicker.tintColor=UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        UIPicker.setValue(UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1), forKey: "textColor")
        self.addSubview(UIPicker)
        
        BotonDismiss.frame=CGRect(x: 350, y: 30, width: 50, height: 50)
        BotonDismiss.tintColor=UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        BotonDismiss.translatesAutoresizingMaskIntoConstraints=true
        BotonDismiss.autoresizingMask = .flexibleLeftMargin
        self.addSubview(BotonDismiss)
        
        
        Botonadd.frame=CGRect(x: 20, y: 30, width: 50, height: 50)
        Botonadd.tintColor=UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        Botonadd.translatesAutoresizingMaskIntoConstraints=true
        Botonadd.autoresizingMask = .flexibleLeftMargin
        self.addSubview(Botonadd)
    }
}



