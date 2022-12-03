# @version ^0.3.7

funders: HashMap[address, uint256]
beneficiary: address
deadline: public(uint256)
goal: public(uint256)
timelimit: public(uint256)


@external
def __int__(_beneficiary: address, _goal: uint256, _timelimit: uint256):
    self.beneficiary = _beneficiary
    self.deadline = block.timestamp + _timelimit
    self.timelimit = _timelimit
    self.goal = _goal

@external
@payable
def participate():
    assert block.timestamp < self.deadline, "deadline not met(yet)"

    self.funders[msg.sender] += msg.value

@external    
def finalize():
    assert block.timestamp >= self.deadline, "deadline has passed"
    assert self.balance >= self.goal, "the goal has not been reached"

    selfdestruct(self.beneficiary)

@external
def refund():
    assert block.timestamp >= self.deadline and self.balance < self.goal
    assert self.funders[msg.sender] > 0

    value: uint256 = self.funders[msg.sender]
    self.funders[msg.sender] = 0

    send(msg.sender, value)