# CoreDataToDoist (Lab)

## Intro
- If you look at the `main` branch you'll see a lot of code already. In fact, this is a functioning to-do app already! 
- But we can do better than functional!
- For starters, this app doesn't save the user's to-do items accross launches. How useful is that?
- For this lab, you will be helping the user persist their data accross launches using (you guessed it) CORE DATA
- Before we dive into Core Data though, familiarize yourself with the project. 

### Get to know the project
  - Run it
  - Type some to-do items
  - check any number of them off as completed
  - Check out the code!
    - Focus on the data flow
    - Where do the Items live?
    - How do you create a new Item?
    - Check out the Diffable DataSource
        - Refamiliarize yourself [here](https://wwdcbysundell.com/2019/diffable-data-sources-first-look/) or [here](https://developer.apple.com/wwdc19/220) if you have no idea what this is
    - Especially look at the `ItemManager` That's where we'll do a lot of our work
      - Right now its simple because all the data is stored in a local array of `[Item]`
      - But pretty soon it will be on the AFTER side of a Before and After Core Data facelift!
  
### Add Core Data Model
- Lets do some modeling. . . Lets start with `Blue Steel` and then move on to `Magnum` jk 😜
- There's already a model file in the project but no entities to be found
- Add a new entity called `Item`
  - Make it match the `Item` found in `Item.swift`
    - id: String
    - title: String
    - createdAt: Date
    - completedAt: Date
  - Set the code generation to `Class Definition`
- Try and Run
- You'll notice some compile errors. What's going on?
  - Well remember what `Class Definition` does? It creates a secret class definition of `Item` and now there' two objects called `Item` and the compiler is not happy!
- Go over to `Item.swift`  and lets make some changes:
  - Delete the struct definition, and the 4 properties and replace it with this line:
  ```
  extension Item { 
  ```
  - Now the properties we were using on `Item.swift` can still be utilized as an extension on the `Core Data` `Item`
  - 
### Add the Stack
### Crud (Create)
### cRud (Retrieve)
### crUd (Update)
### cruD (Delete)


