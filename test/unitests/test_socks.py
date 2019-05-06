from test.constants import (
    DECIMALS,
)

def test_init(w3, SOCKS):
    a0, a1 = w3.eth.accounts[:2]
    assert SOCKS.name() == 'Unisocks Edition 0'
    assert SOCKS.symbol() == 'SOCKS'
    assert SOCKS.decimals() == 18
    assert SOCKS.totalSupply() == 1000*DECIMALS
    assert SOCKS.balanceOf(a0) == 1000*DECIMALS

def test_transfer(w3, SOCKS):
    a0, a1 = w3.eth.accounts[:2]
    SOCKS.transfer(a1, 1*10**18, transact={})
    assert SOCKS.balanceOf(a0) == 1000*DECIMALS - 1*DECIMALS
    assert SOCKS.balanceOf(a1) == 1*DECIMALS
