# @version ^0.3.7

greeting: public(String[100])

@external 
def __init__(): 
    self.greeting = "Howdy Doodee!" 
@external 
def greet() -> String[100]: 
    return self.greeting

struct User: 
    name: String[100] 
    created: uint256 