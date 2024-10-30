import { assertTrue, assertFalse, assertEquals } from 'vitest'
import { Clarinet, Tx, Chain, Account, types } from 'clarinet'

Clarinet.test({
  name: "Decentralized Content Subscription Platform",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    let buyer = accounts.get('wallet_1')!
    let seller = accounts.get('wallet_2')!
    let contentId = 'my-content'
    let paymentAmount = 1000
    let royaltyPercentage = 20
    
    // Test subscribe and withdraw
    let tx = await Tx.invokeContract(buyer, 'subscribe', [types.ascii(contentId), types.uint(paymentAmount)])
    assertTrue(await isSubscriptionExists(chain, buyer.address, contentId))
    
    tx = await Tx.invokeContract(seller, 'set-royalty', [types.ascii(contentId), types.uint(royaltyPercentage)])
    assertEquals(await getRoyalty(chain, contentId), royaltyPercentage)
    
    tx = await Tx.invokeContract(seller, 'report-earnings', [types.ascii(contentId), types.uint(1000)])
    assertEquals(await getEarnings(chain, seller.address, contentId), (1000 * royaltyPercentage) / 100)
    
    tx = await Tx.invokeContract(seller, 'withdraw', [types.ascii(contentId)])
    assertFalse(await getEarnings(chain, seller.address, contentId) > 0)
    assertFalse(await Tx.invokeContract(seller, 'withdraw', [types.ascii(contentId)]).successful)
  }
})

// Helper functions
async function isSubscriptionExists(chain: Chain, principal: string, contentId: string): Promise<boolean> {
  let contract = chain.getContract('decentralized-content-subscription', principal)
  let result = await contract.call('subscription-exists?', [types.principal(principal), types.ascii(contentId)])
  return result.value;
}

async function getRoyalty(chain: Chain, contentId: string): Promise<number> {
  let contract = chain.getContract('decentralized-content-subscription', '');
  let result = await contract.call('get-royalty', [types.ascii(contentId)])
  return result.value;
}

async function getEarnings(chain: Chain, principal: string, contentId: string): Promise<number> {
  let contract = chain.getContract('decentralized-content-subscription', principal)
  let result = await contract.call('get-earnings', [types.principal(principal), types.ascii(contentId)])
  return result.value
}
