# Decentralized Content Subscription Platform

## Overview
This project creates a decentralized platform where content creators can monetize their work through subscriptions, with transparent earnings.

## Key Features
- Subscription payments
- Content gating
- Royalty distribution
- Creator dashboard with analytics

## Smart Contract
The Clarity smart contract provides:
1. Subscriptions: Tracks details, allows subscribing.
2. Creator Royalties: Sets percentages, tracks royalties.
3. Creator Earnings: Tracks earnings, allows withdrawal.
4. Earnings Reporting: Calculates royalties based on reported earnings.

## Testing
The contract has a Vitest test suite covering:
1. Subscribing, setting royalties, reporting/withdrawing earnings.
2. Verifies subscription, royalties, earnings calculations.

To run tests, install Vitest in your Clarity environment.

## Usage
1. Deploy contract to Stacks blockchain.
2. Creators set royalties, users subscribe, creators report earnings.
3. Creators withdraw their earnings.

## Future
- Content gating
- User authentication
- Enhanced creator analytics
- Decentralized storage integration

## Contributions
Submit issues/PRs on the GitHub repository.
