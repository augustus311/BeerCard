//
//  ContentView.swift
//  BeerCards
//
//  Created by User on 05/08/2023.
//

import SwiftUI

struct Quote: Codable {
    var id: Int
    var name: String
    var tagline: String
    
    
}


struct ContentView: View {
    
    @State private var searchTerm = ""
    @State private var quotes = [Quote]()
    
    
    
    
    var body: some View {
        NavigationView {
         List(quotes,  id: \.id) { quote in
            VStack(alignment: .leading) {
                
                Text(quote.name).position(x: 150, y: 10)
                    .font(.headline)
                    .foregroundColor(Color("skyBlue"))
                Text(quote.tagline)
                    .font(.body)
                    .foregroundColor(.secondary).position(x: 150, y: 10)
                
                
                                        
                
            }
        }
         .navigationTitle("OakTyres Test")
         
        .task{
            await fetchData()
        }
        .searchable(text: $searchTerm, prompt: "Search Beer")
        }
    }
    
        @Sendable func fetchData() async {
        // create url
        guard let url = URL(string: "https://api.punkapi.com/v2/beers") else{
            return
        }
        
        // fetch data from that url
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
        
        
        // decode that data
        if let decodedResponse = try? JSONDecoder().decode([Quote].self, from: data) {
            quotes = decodedResponse
        }
    } catch {
        print("bad news not working")
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


