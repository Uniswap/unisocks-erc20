def test_socks(w3, SOCKS):
    a0, a1 = w3.eth.accounts[:2]
    assert SOCKS.name() == 'Unisocks Version 0.1'
    assert SOCKS.symbol() == 'SOCKS'
    assert SOCKS.decimals() == 18
    assert SOCKS.totalSupply() == 1000*10**18
    assert SOCKS.balanceOf(a0) == 1000*10**18
    SOCKS.transfer(a1, 1*10**18, transact={})
    assert SOCKS.balanceOf(a0) == 1000*10**18 - 1*10**18
    assert SOCKS.balanceOf(a1) == 1*10**18
