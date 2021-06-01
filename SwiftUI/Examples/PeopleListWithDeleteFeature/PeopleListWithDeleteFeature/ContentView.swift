//
//  ContentView.swift
//  PeopleListWithDeleteFeature
//
//  Created by Dannian Park on 2021/05/20.
//

import SwiftUI

struct PeopleList: View {
    @State var people: [Person] = [
        .init(firstName: "Steve", lastName: "Jobs", image: #imageLiteral(resourceName: "pngegg"), jobTitle: "Founder of Apple"),
        .init(firstName: "Tim", lastName: "Cook", image: #imageLiteral(resourceName: "pngegg"), jobTitle: "Apple CEO"),
        .init(firstName: "Jony", lastName: "Ive", image: #imageLiteral(resourceName: "pngegg"), jobTitle: "Head of Design")
    ]
    
    @State var isPresentingAddModal = false
    var body: some View {
        NavigationView {
            List(people) { person in
                PersonRow(person: person, didDelete: { p in
                    self.people.removeAll(where: { $0.id == person.id })
                })
            }.navigationBarTitle("People")
                .navigationBarItems(trailing: Button(action: {
                    print("Add New Person")
                    self.isPresentingAddModal.toggle()
                }, label: {
                    Text("Add")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.green)
                        .cornerRadius(4)
                }))
            .sheet(isPresented: $isPresentingAddModal, content: {
                AddModal(isPresented: $isPresentingAddModal, didAddPerson: { person in
                    print("PERSON: \(person.firstName) :: \(person.lastName)")
                    self.people.append(person)
                })
            })
            
        }
    }
}

struct AddModal: View {
    
    @Binding var isPresented : Bool
    
    @State var firstName = ""
    @State var lastName = ""
    
    var didAddPerson: (Person) -> ()
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                Text("First name")
                TextField("Enter First Name", text: $firstName)
                    .padding(.all, 10)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
            }
            
            HStack(spacing: 16) {
                Text("Last Name")
                TextField("Enter last Name", text: $lastName)
                    .padding(.all, 10)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
            }
            
            Button(action: {
                self.isPresented = false
                print("name : \(self.firstName)")
                self.didAddPerson(.init(firstName: self.firstName, lastName: self.lastName, image: UIImage(), jobTitle: "NEW JOB"))
            }, label: {
                Spacer()
                Text("ADD")
                Spacer()
            })
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .background(Color.green)
                .cornerRadius(4)
            
            Button(action: {
                self.isPresented = false
            }, label: {
                Spacer()
                Text("Cancel")
                Spacer()
            })
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .background(Color.red)
                .cornerRadius(4)
            
            Spacer()
        }
        .padding(.all, 16)
    }
}

struct PersonRow: View {
    var person: Person
    var didDelete: (Person) -> ()
    
    var body: some View {
        HStack {
            Image(uiImage: person.image)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .overlay(RoundedRectangle(cornerRadius: 60)
                            .strokeBorder(style: StrokeStyle(lineWidth: 2))
                            .foregroundColor(.black)
                )
                .cornerRadius(60)
            VStack(alignment: .leading) {
                Text("\(person.firstName) \(person.lastName)")
                    .fontWeight(.bold)
                Text(person.jobTitle)
                    .fontWeight(.bold)
            }.layoutPriority(1)
            
            Spacer()
            
            Button(action: {
                print("Deleting: \(self.person.firstName)")
                self.didDelete(self.person)
            }, label: {
                Text("Delete")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.all, 12)
                    .background(Color.red)
                    .cornerRadius(3)
            })
        }.padding(.vertical, 8)
    }
}

struct PeopleList_Previews: PreviewProvider {
    static var previews: some View {
        PeopleList()
    }
}


struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
