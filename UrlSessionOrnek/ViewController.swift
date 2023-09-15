//
//  ViewController.swift
//  UrlSessionOrnek
//
//  Created by Dilan Öztürk on 2.04.2023.
//

import UIKit

// normalde internetten veri çekeceğimiz zaman alamofire ı kullanırdık. burada urlsession ı kullanarak internetten bir resim çekciez. bazı projelerde hem alomafire hem de urlsession da kullanılmış olabilir

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.resimYukle(urlString: "https://static.ticimax.cloud/30771/uploads/urunresimleri/elma-starking-kg-13da.jpg")
    }
    
    private func resimYukle (urlString : String) {
        
        guard let url = URL(string : urlString) else {return} // hangi url e bağlanacağımızı yazıyoruz. bir sorun varsa da return sayesinde aşağılara uğramayacak
        
        let session = URLSession.shared // shared görünce singleton aklımıza gelmeli. nesne yoksa ilk seferinde oluştur varsa var olan nesne üzerinden git
        let task = session.dataTask(with: url) { data, response, error in // bu bir closure. buna verdiğimiz url le arka planda completionHandler da neler tanımlıysa onlar devreye girecek. response sayesinde istenen data gelmezse 404 dönüyo. arka planda yapılan işleri task a atıyoruz
            if let error = error {
                print(error.localizedDescription)
                return // hata alırsa return sayesinde aşağı gitmesi engellenecek
            }
            guard let data = data else {return} // eğer hata yoksa
            DispatchQueue.main.async { // asenkron biçimde gelen veri işlenecek
                self.imageView.image = UIImage(data: data) // datayı imageview e geçiricez. data verdiğimizde onu bir resme dönüştürecek. resmin image özelliğine bunu verirsek resmi oluşturacak
            }
        }
        task.resume() // bunu çağırmazsak yukarıdaki kodlar çalışmaz
        
    }


}

