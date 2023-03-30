//
//  TestView.swift
//  CoreDataCodable
//
//  Created by Danjuma Nasiru on 24/02/2023.
//

import SwiftUI

struct TestView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var xxxdata : FetchedResults<XXX>
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(xxxdata, id: \.self){data in
                        Text(data.name)
                    }
                }
                
                Button("load data"){
                    Task{
                        if xxxdata.isEmpty{
                            await getData()
                        }
                    }
                }
            }.navigationTitle("Testing")
            
        }
    }
    
    func getData() async{
        do {
            guard let url = Bundle.main.url(forResource: "simpleJson.json", withExtension: nil) else{return}
            guard let data = try? Data(contentsOf: url) else{return}
            
            let decoder = JSONDecoder()
            
            decoder.userInfo[CodingUserInfoKey.managedObjectContect!] = self.moc
            var decodedData = try decoder.decode([XXX].self, from: data)
            
            
            try moc.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
