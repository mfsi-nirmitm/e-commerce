<cfset myStruct = {
    items: {
        item1:  {name: 'something', price: 1000},
        item2:  {name: 'something else', price: 12.50},
        item3:  {name: 'something more', price: "1,240.10"}
    },
    users: {
        user1:  {id: 1, email: 'none@none.net'},
        user2:  {id: 2, email: 'none@none.net'},
        user3:  {id: 3, email: 'none@none.net'}
    }
} />
<cfset myJsonVar = serializeJSON(myStruct) />
<cfdump var="#isJson(myJsonVar)#" />