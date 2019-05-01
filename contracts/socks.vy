# ERC20 implementation adapted from https://github.com/ethereum/vyper/blob/master/examples/tokens/ERC20.vy

Transfer: event({_from: indexed(address), _to: indexed(address), _value: uint256})
Approval: event({_owner: indexed(address), _spender: indexed(address), _value: uint256})

name: public(string[64])
symbol: public(string[32])
decimals: public(uint256)
balanceOf: public(map(address, uint256))
allowances: map(address, map(address, uint256))
total_supply: uint256


@public
def __init__(_supply: uint256):
    self.name = 'Unisocks Version 0.1'
    self.symbol = 'SOCKS'
    self.decimals = 18
    self.balanceOf[msg.sender] = _supply
    self.total_supply = _supply
    log.Transfer(ZERO_ADDRESS, msg.sender, _supply)


@public
@constant
def totalSupply() -> uint256:
    return self.total_supply


@public
@constant
def allowance(_owner : address, _spender : address) -> uint256:
    return self.allowances[_owner][_spender]


@public
def transfer(_to : address, _value : uint256) -> bool:
    self.balanceOf[msg.sender] -= _value
    self.balanceOf[_to] += _value
    log.Transfer(msg.sender, _to, _value)
    return True


@public
def transferFrom(_from : address, _to : address, _value : uint256) -> bool:
    self.balanceOf[_from] -= _value
    self.balanceOf[_to] += _value
    if _value < MAX_UINT256:
        self.allowances[_from][msg.sender] -= _value
    log.Transfer(_from, _to, _value)
    return True


@public
def approve(_spender : address, _value : uint256) -> bool:
    self.allowances[msg.sender][_spender] = _value
    log.Approval(msg.sender, _spender, _value)
    return True


@private
def _burn(_to: address, _value: uint256):
    assert _to != ZERO_ADDRESS
    self.total_supply -= _value
    self.balanceOf[_to] -= _value
    log.Transfer(_to, ZERO_ADDRESS, _value)


@public
def burn(_value: uint256) -> bool:
    self._burn(msg.sender, _value)
    return True


@public
def burnFrom(_to: address, _value: uint256) -> bool:
    if _value < MAX_UINT256:
        self.allowances[_to][msg.sender] -= _value
    self._burn(_to, _value)
    return True
