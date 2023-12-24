//
//  DrillView.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 23/11/2023.
//

import SwiftUI
import Charts
import CoreData

struct DrillView: View {
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    var provider = CoreDataProvider.shared
    private let context: NSManagedObjectContext
    @FetchRequest(fetchRequest: Wallet.all()) private var wallets
    @FetchRequest(fetchRequest: Stuffs.all()) private var stuffs
    @FetchRequest(fetchRequest: Stuffs.byCategory(category: "1")) private var samurai
    @FetchRequest(fetchRequest: Stuffs.byCategory(category: "2")) private var camping
    @FetchRequest(fetchRequest: Stuffs.byCategory(category: "3")) private var gaming
    @FetchRequest(fetchRequest: Stuffs.byCategory(category: "4")) private var sports
    @FetchRequest(fetchRequest: Stuffs.byCategory(category: "5")) private var space
    @State private var selectedCategory:String = "1"
    private var stickersCategory:[String] = ["1", "2", "3", "4", "5"]
    init() {
        self.context = provider.newContext
    }
    
    var body: some View {
        NavigationStack(path: $navigationStateManager.selectionPath) {
            VStack(alignment: .leading) {
                //MARK: My Stickers
                HStack {
                    Text("my_stickers".localized(language))
                        .font(.title2).bold()
                    Image("sticky-notes")
                        .resizable()
                        .frame(width: 25, height: 25)
                    Spacer()
                    HStack(alignment: .center) {
                        Image("coin")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("\(wallets.first?.coins ?? 0)").font(.title2).foregroundColor(.secondary).bold()
                        
                    }
                }
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 10) {
                    ForEach(stickersCategory, id: \.self) { category in
                        VStack {
                            HStack {
                                Text(getTitlebyCategory(category: category)).font(.subheadline)
                                Spacer()
                                Image(systemName: "chevron.right").font(.caption)
                            }
                            Spacer().frame(height: 5)
                            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10) {
                                ForEach(getStickersbyCategory(category: category)) { sticker in
                                    if (sticker.unlocked) {
                                        
                                    Image(sticker.image ?? "")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        
                                    } else {
                                     Image(sticker.image ?? "")
                                        .resizable()
                                        .frame(width: 30, height: 30).opacity(0.4)
       
                                    }
                                }
                                
                            }
                            Spacer().frame(height: 10)
                            ProgressView(value: getProgressbyCategory(category: category), total: 9.0)
                                           .progressViewStyle(LinearProgressViewStyle())

                        }
                        .onTapGesture {
                            selectedCategory = category
                            navigationStateManager.selectionPath.append("my-stickers")
                        }
                        .padding(10)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    
                }
               
                Spacer()
                //MARK: Earn Coin
               
                VStack(alignment: .leading, spacing: 10) {
                    Button {
                        navigationStateManager.selectionPath.append("loading-drill-session")
                    } label: {
                        HStack {
                            Spacer()
                            Text("get_coins".localized(language))
                                .font(.title).bold()
                            Image("mathematical-sign")
                                .resizable()
                                .frame(width: 25, height: 25)
                            Spacer()
                        }
                        
                    }
                    .foregroundColor(.primary)
                }
                .padding()
                .background(.green)
                .cornerRadius(25)
                Spacer().frame(height: 25)
                
            }
            .padding()
            .navigationDestination(for: String.self) { textValue in
                if (textValue == "drill") {
                    DrillView()
                }
                if (textValue == "drill-session") {
                    DrillSessionView()
                }
                if (textValue == "loading-drill-session") {
                    LoadingView()
                }
                if (textValue == "session-detail") {
                    SessionDetailView()
                }
                if (textValue == "my-stickers") {
                    ShopView(category: selectedCategory)
                }
            }
        }
        .onAppear {
            if wallets.isEmpty {
                initializeWallet()
            }
            if stuffs.isEmpty {
                initializeStuffs()
            }
        }
    }
    
    func getTitlebyCategory(category:String) -> String {
        switch category {
        case "1":
            return "samurai_cats".localized(language)
        case "2":
            return "outdoor_camping".localized(language)
        case "3":
            return "gaming".localized(language)
        case "4":
            return "sports".localized(language)
        case "5":
            return "outer_space".localized(language)
        default:
            return "samurai_cats".localized(language)
        }
    }
    
    func getStickersbyCategory(category:String) -> FetchedResults<Stuffs> {
        switch category {
        case "1":
            return samurai
        case "2":
            return camping
        case "3":
            return gaming
        case "4":
            return sports
        case "5":
            return space
        default:
            return samurai
        }
    }
    
    func getProgressbyCategory(category:String) -> Double {
        let stuffs = getStickersbyCategory(category: category)
        return Double(stuffs.filter { $0.unlocked == true }.count)
    }
    
    func initializeWallet() {
        let newWallet:Wallet = Wallet(context: context)
        newWallet.coins = 10
        do {
            try context.save()
        } catch {
        }
        
    }
    
    func initializeStuffs() {
        print("called")
        let products:[Products] = loadProductsFromJson()
        for product in products {
            let newStuffs = Stuffs(context: context)
            newStuffs.name = product.name
            newStuffs.category = product.category
            newStuffs.price = Int16(product.price)
            newStuffs.unlocked = false
            newStuffs.image = product.image
        }
        do {
            try context.save()
        } catch {
        }
    }
    
    func loadProductsFromJson() -> [Products] {
        if let fileURL = Bundle.main.url(forResource: "Products", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileURL)
                let decodedData = try JSONDecoder().decode([Products].self, from: data)
                return decodedData
            } catch {
                print("Error loading JSON data: \(error)")
            }
        }
        return []
    }
    
    
}

#Preview {
    DrillView().environmentObject(NavigationStateManager())
}
