//
//  ShopView.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 21/12/2023.
//

import SwiftUI
import CoreData

struct ShopView: View {
    private var language = LocalizationService.shared.language
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @FetchRequest(fetchRequest: Wallet.all()) private var wallets
    private var category:String = "1"
    @State private var showSnackbar = false
    
    @State private var selectedIndex: Int = 0
    @State private var unlockConfirmation = false
    
    @FetchRequest var stuffs: FetchedResults<Stuffs>
    init(category: String) {
        self.category = category
        _stuffs = FetchRequest(fetchRequest: Stuffs.byCategory(category: category))
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Text(getTitlebyCategory(category:category))
                    .font(.title2).bold()
                Spacer()
                HStack(alignment: .center) {
                    Image("coin")
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text("\(wallets.first?.coins ?? 0)").font(.title2).foregroundColor(.secondary).bold()
                    
                }
            }
            .padding(.horizontal, 10)
            if showSnackbar {
                SnackbarView(message: "not_enough_coin".localized(language), isPresented: $showSnackbar)
            }
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 10) {
                    ForEach(0..<stuffs.count) { i in
                        Button {
                            if (!stuffs[i].unlocked) {
                                unlockConfirmation = true
                                selectedIndex = i
                            }
                        } label: {
                            VStack {
                                if (stuffs[i].unlocked) {
                                    HStack {
                                        Spacer()
                                        Image(stuffs[i].image ?? "").resizable().frame(width: 150, height: 150)
                                        Spacer()
                                    }
                                } else {
                                    ZStack {
                                        Image(stuffs[i].image ?? "").resizable().frame(width: 150, height: 150).opacity(0.2)
                                        HStack {
                                            Spacer()
                                            Image("coin")
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                            Text("\(stuffs[i].price)").bold()
                                            Spacer()
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding(.all, 10)
                            .background(.gray.opacity(0.1))
                            .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .alert(isPresented: $unlockConfirmation) {
                            Alert(
                                title: Text("\(stuffs[selectedIndex].price)"),
                                message: Text("purchase".localized(language)),
                                primaryButton: .default(Text("yes".localized(language))) {
                                    let coins = wallets.first?.coins ?? 0
                                    if (coins >= stuffs[selectedIndex].price) {
                                        viewContext.perform {
                                            stuffs[selectedIndex].unlocked = true
                                            wallets.first?.coins -= stuffs[selectedIndex].price
                                            do {
                                                try viewContext.save()
                                            } catch {
                                            }
                                        }
                                    } else {
                                        showSnackbar.toggle()
                                        
                                    }
                                },
                                secondaryButton: .cancel(Text("no".localized(language)))
                            )
                        }
                        
                    }
                }
             
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    navigationStateManager.popToRoot()
                }) {
                    Image(systemName: "chevron.left")
                    Text("back".localized(language))
                }
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
}

struct SnackbarView: View {
    let message: String
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(message)
                    .foregroundColor(.pink)
                    .cornerRadius(10)
            }
            .padding(10)
            .opacity(isPresented ? 1 : 0)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isPresented = false
                }
            }
        }
    }
}


#Preview {
    ShopView(category: "1")
}
