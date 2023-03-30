//
//  ContentView.swift
//  CoreDataCodable
//
//  Created by Danjuma Nasiru on 10/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var cachedUsers : FetchedResults<User>
    
   
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(cachedUsers, id: \.id){user in
                        NavigationLink{
                            UserDetails(user: user)
                        } label: {
                            HStack(alignment: .bottom){
                                Text(user.wrappedName)
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 0){
                                    user.isActive ? Text("Online") : Text("Offline")
                                    Image(systemName: "circle.fill").resizable().scaledToFit().frame(width: 10, height: 10).foregroundColor(user.isActive ? .green : .gray)
                                }
                            }
                        }
                    
                    }}.task{
                        if cachedUsers.isEmpty{
                            await fetchdata()
                        }
                                        
                    }
                
                
            }.navigationTitle("Users")
        }
    }
    
    func fetchdata() async{
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { return }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        do{
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContect!] = self.moc
            decoder.dateDecodingStrategy = .iso8601
            
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            _ = try decoder.decode([User].self, from: data)
            
//            try moc.save()
            //users = decodedData
        }
        catch{
            print(error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
