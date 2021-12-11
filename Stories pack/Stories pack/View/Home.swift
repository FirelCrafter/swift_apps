//
//  Home.swift
//  Stories pack
//
//  Created by Михаил Щербаков on 13.11.2021.
//

import SwiftUI

struct Home: View {
    
    @State var cards = [
        
        Card(cardColor: Color("blue"), date: "Monday 8th November", title: "Neurobics for your \nmind."),
        Card(cardColor: Color("purple"), date: "Tuesday 9th November", title: "Brush up on hygine."),
        Card(cardColor: Color("green"), date: "Wednesday 10th November", title: "Don't skip breakfast."),
        Card(cardColor: Color("pink"), date: "Thirsday 11th November", title: "Brush up on hygine."),
        Card(cardColor: Color("yellow"), date: "Friday 8th November", title: "Neurobics for your \nmind.")
        
    ]
    
    // Detail view
    
    @State var showDetailPage: Bool = false
    @State var currentCard: Card?
    
    @Namespace var animation
    
    @State var showDetailContent: Bool = false
    
    var body: some View {
        VStack {
            
            HStack (alignment: .bottom) {
                
                VStack(alignment: .leading) {
                    
                    
                    Text("9TH of NOV")
                        .font(.largeTitle.bold())
                    
                    Label {
                        Text("New York, USA")
                    } icon: {
                        Image(systemName: "location.circle")
                    }
                }
                
                Spacer()
                
                Text("Updated 1:30 PM")
                    .font(.caption2)
                    .fontWeight(.light)
            }
            
            GeometryReader { proxy in
                
                let size = proxy.size
                let trailingCardsToShow: CGFloat = 2
                let trailingSpaceofEachCards: CGFloat = 20
                
                
                ZStack {
                    ForEach(cards) { card in
                        InfiniteStackedCardView(cards: $cards, card: card, trailingCardsToShow: trailingCardsToShow, trailingSpaceofEachCards: trailingSpaceofEachCards, animation: animation, showDetailPage: $showDetailPage)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    currentCard = card
                                    showDetailPage = true
                                }
                            }
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, (trailingCardsToShow * trailingSpaceofEachCards))
                .frame(height: size.height / 1.6)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .overlay(
            DetailPage()
        )
    }
    
    @ViewBuilder
    func DetailPage()-> some View {
        ZStack {
            if let currentCard = currentCard, showDetailPage {
                
                Rectangle()
                    .fill(currentCard.cardColor)
                    .matchedGeometryEffect(id: currentCard.id, in: animation)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Button {
                        withAnimation {
                            showDetailContent = false
                            showDetailPage = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.black)
                            .padding(10)
                            .background(Color.white.opacity(0.6))
                            .clipShape(Circle())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(currentCard.date)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .padding(.top)
                    
                    Text(currentCard.title)
                        .font(.title.bold())
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        Text(content)
                            .padding(.top)
                    }
                    
                }
                .opacity(showDetailContent ? 1: 0)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        withAnimation {
                            showDetailContent = true
                        }
                    }
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct InfiniteStackedCardView: View {
    
    @Binding var cards: [Card]
    var card: Card
    
    var trailingCardsToShow: CGFloat
    var trailingSpaceofEachCards: CGFloat
    
    var animation: Namespace.ID
    @Binding var showDetailPage: Bool
    
    @GestureState var isDragging: Bool = false
    @State var offset: CGFloat = .zero
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            
            Text(card.date)
                .font(.caption)
                .fontWeight(.semibold)
            
            Text(card.title)
                .font(.title.bold())
                .padding(.top)
            
            Spacer()
            
            Label {
                Image(systemName: "arrow.right")
            } icon: {
                Text("Read more")
            }
            .font(.system(size: 15, weight: .semibold))
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            
            
        }
        .padding()
        .padding(.vertical, 10)
        .foregroundColor(.white)
        .background(
            ZStack {
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(card.cardColor)
                    .matchedGeometryEffect(id: card.id, in: animation)
                
            }
        )
        .padding(.trailing, -getPadding())
        .padding(.vertical, getPadding())
        .zIndex(Double(CGFloat(cards.count) - getIndex()))
        .rotationEffect(.init(degrees: getRotation(angle: 10)))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .offset(x: offset)
        .gesture(
            DragGesture()
                .updating($isDragging, body: { _, out, _ in
                    out = true
                })
                .onChanged({value in
                    
                    var translation = value.translation.width
                    
                    translation = cards.first?.id == card.id ? translation : 0
                    translation = isDragging ? translation : 0
                    translation = (translation < 0 ? translation : 0)
                    offset = translation
                })
                .onEnded({value in
                    
                    let width = UIScreen.main.bounds.width
                    let cardPassed = -offset > (width / 2)
                    
                    withAnimation(.easeInOut(duration: 0.2)) {
                        
                        if cardPassed {
                            offset = -width
                            removeAndPutBack()
                        } else {
                            offset = .zero
                        }
                        
                    }
                })
        )
    }
    
    func removeAndPutBack() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            var updateCard = card
            updateCard.id = UUID().uuidString

            cards.append(updateCard)
            
            withAnimation {
                cards.removeFirst()
            }
        }
        
    }
    
    func getRotation(angle: Double) -> Double {
        
        let width = UIScreen.main.bounds.width - 50
        let progress = offset / width
        
        return Double(progress) * angle
        
    }
    
    func getPadding() -> CGFloat {
        
        let maxPadding = trailingCardsToShow * trailingSpaceofEachCards
        
        let cardPadding = getIndex() * trailingSpaceofEachCards
        
        return(getIndex() <= trailingCardsToShow ? cardPadding : maxPadding)
        
    }
    
    func getIndex() -> CGFloat {
        
        let index = cards.firstIndex{ card in
            return self.card.id == card.id
        } ?? 0
        
        return CGFloat(index)
        
    }
    
}

let content = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
