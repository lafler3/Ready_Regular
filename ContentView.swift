//
//  ContentView.swift
//  Shared
//
//  Created by Ryan Lafl on 11/6/21.
//

import SwiftUI




struct ItemObject{
    var name: String = ""
    var priceIndividual: String = ""
}

struct ListObject{
    var title: String = ""
    var provider: String = ""
    var state: String = ""
    var itemNum: Int = 0
    var items: Array<ItemObject> = Array()
    var priceTotal: Double = 0
    
}

struct CardView: View{
    let stuff: ItemObject
    var body: some View{
        VStack(alignment: .leading){
            Text(stuff.name)
                .font(.headline)
            Spacer()
            Text(stuff.priceIndividual)
                .font(.caption)
        }
    }
}

struct CardView2: View{
    let stuffs: ListObject
    var body: some View{
        VStack(alignment: .leading){
            HStack(){
                Text(stuffs.title)
                    .font(.headline)
                Spacer()
                Text(String(stuffs.priceTotal))
                    .font(.headline)
            }
            Spacer()
            HStack(){
                Text(stuffs.provider)
                    .font(.caption)
                Spacer()
                Text(stuffs.state)
                    .font(.caption)
                Spacer()
                Text((String(stuffs.itemNum) + " items in list"))
                    .font(.caption)
            }
        }
    }
}



struct ContentView: View {
    
    @State public var pr: String = ""
    @State public var st: String = ""
    @State public var tt: String = ""
    @State public var itn: String = ""
    @State public var itp: String = ""
    @State public var priceHold: Double = 0.0
    @State public var holder: ItemObject = ItemObject()
    @State public var listHold: ListObject = ListObject()
    @State public var items: Array<ItemObject> = Array()
    @State public var lists: Array<ListObject> = Array()
    @State public var dict: [String: Double]=[
        "al":  0.04
    ,"ak":  0.00
    ,"az":  0.056
    ,"ar":  0.065
    ,"ca":  0.0725
    ,"co":  0.029
    ,"ct":  0.0635
    ,"de":  0
    ,"fl":  0.06
    ,"ga":  0.04
    ,"hi":  0.04
    ,"id":  0.06
    ,"il":  0.0625
    ,"ia":  0.06
    ,"ks":  0.065
    ,"ky":  0.06
    ,"la":  0.0445
    ,"me":  0.055
    ,"md":  0.06
    ,"ma":  0.0625
    ,"mi":  0.06
    ,"mn":  0.06875
    ,"ms":  0.07
    ,"mo":  0.04225
    ,"mt":  0
    ,"ne":  0.055
    ,"nv":  0.0685
    ,"nh":  0
    ,"nj":  0.06625
    ,"nm":  0.05125
    ,"ny":  0.04
    ,"nc":  0.0475
    ,"nd":  0.05
    ,"oh":  0.0575
    ,"ok":  0.045
    ,"or":  0
    ,"pa":  0.06
    ,"ri":  0.07
    ,"sc":  0.06
    ,"sd":  0.045
    ,"tn":  0.07
    ,"tx":  0.06250
    ,"ut":  0.04850
    ,"vt":  0.06
    ,"va":  0.043
    ,"wa":  0.065
    ,"wv":  0.06
    ,"wi":  0.05
    ,"wy":  0.04
    ]

    
    var body: some View {
        
        VStack(alignment: .center) {
            Text("Enter Information for a new Regular List")
            HStack(alignment: .center){
                Spacer()
                Spacer()
                Spacer()
                    .padding(.horizontal)
                TextField("List Title", text: $tt)
                Spacer()
                    .padding(.horizontal)
            }
            HStack(){
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                TextField("Provider", text: $pr)
                Spacer()
                TextField("State (NY format)", text: $st)
                Spacer()
            }
            HStack(){
                Spacer()
                Spacer()
                Spacer()
                TextField("Item", text: $itn)
                Spacer()
                TextField("Price", text: $itp)
                Spacer()

                Button("Add Item"){
                    listHold.itemNum+=1
                    priceHold += (Double(itp) ?? 0)
                    holder.name = itn
                    holder.priceIndividual = itp
                    items.append(holder)
                    holder.name = ""
                    holder.priceIndividual = ""
                    itn = ""
                    itp = ""
                }
                Spacer()
                Spacer()
            }
            
            List{
                ForEach(items, id: \.name){
                    item in CardView(stuff: item)
                }
            }
            Button("Add List"){
                listHold.items.append(contentsOf: items)
                items.removeAll()
                listHold.title = tt
                listHold.provider = pr
                listHold.state = st
                listHold.priceTotal = priceHold + (priceHold * (dict[st.lowercased()] ?? 0))
                lists.append(listHold)
                listHold.items.removeAll()
                listHold.title = ""
                listHold.provider = ""
                listHold.itemNum = 0
                listHold.priceTotal = 0
                listHold.state = ""
                priceHold = 0
            }
            //close item button - clear items list, add stuff to master list
            //have mast display list
            //kill button in the card? thoughts for tommorow
            Spacer()
            List{
                ForEach(lists, id: \.title){
                    list in CardView2(stuffs: list)
                }
            Spacer()
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
