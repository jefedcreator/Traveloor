# Traveloor

Traveloor is a platform that can make it easier for users to purchase exclusive travel and vacation access in form of NFTs. Traveloor is an ERC1155 smart contract that handles five types of ERC721 Nfts: FLIGHT tickets, CRUISE tickets, HOTEL tickets, TRAIN tickets, and PREMIUM tickets which allows access to the other four NFTs, provided users have previously purchased an NFT, and for a slightly higher cost.

- [Traveloor](#chainlink-mix)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Testnet Development](#testnet-development)
  - [Running Scripts and Deployment](#running-scripts-and-deployment)
    - [Setup Contract](#setup-contract)
    - [Thriftoor Simulation](#Thriftor-simulation-and-Testing)
  - [License](#license)

## Prerequisites

Please install or have installed the following:

- [nodejs and npm](https://nodejs.org/en/download/)
## Installation

1. [Install Hardhat](https://hardhat.org/hardhat-runner/docs/getting-started#overview), if you haven't already. Here is a simple way to install brownie.


```bash
yarn add hardhat
yarn hardhat
```
Or, if that doesn't work, via npm
```bash
npm add hardhat
npm hardhat
```

2. Download the project and install dependencies.

```bash
git clone https://github.com/jefedcreator/Traveloor/
cd Traveloor
yarn install
```

## Testnet Development
Before we deploy to the Ropsten network, do the following.

Set your `ETHERSCAN_API_KEY`, ` ROPSTEN_URL` and `PRIVATE_KEY` [environment variables](https://www.twilio.com/blog/2017/01/how-to-set-environment-variables.html).

You can get a `ROPSTEN_URL` by getting a free trial of [Alchemy](https://dashboard.alchemyapi.io/). If you get lost, you can [follow this guide](https://docs.alchemy.com/reference/api-overview) to getting a project key. You can find your `PRIVATE_KEY` from your ethereum wallet like [metamask](https://metamask.io/) or you can create a temporary mnemonic to test this project [Bip39 Mnemonic Code](https://iancoleman.io/bip39/)

You'll also need testnet ETH and LINK. You can get LINK and ETH into your wallet by using the [faucets located here](https://docs.chain.link/docs/link-token-contracts). If you're new to this, [watch this video.](https://www.youtube.com/watch?v=P7FX_1PePX0). Look at the `ropsten` sections for those specific testnet faucets. 

You'll also need etherscan API key in order to verify the contracts . You can get instruction guide on getting your API Kes here [follow the instructions here](https://www.topcoder.com/thrive/articles/using-the-etherscan-api-and-bubble).

You can add your environment variables to a `.env` file. You can use the [.env.exmple](https://github.com/jefedcreator/Traveloor/blob/main/.env.example) as a template, just fill in the values and rename it to '.env'.

Here is what your `.env` should look like:
```
ETHERSCAN_API_KEY=<API_KEY>
ROPSTEN_URL=<ROPSTEN_URL>
PRIVATE_KEY=<PRIVATE_KEY>
```


![WARNING](https://via.placeholder.com/15/f03c15/000000?text=+) **WARNING** ![WARNING](https://via.placeholder.com/15/f03c15/000000?text=+)

DO NOT SEND YOUR PRIVATE KEY WITH FUNDS IN IT ONTO GITHUB

## Running Scripts and Deployment

### Setup Contract

This will deploy the smart contract to ropsten and verify it on the block explorer.
```bash
yarn hardhat run scripts/deploy.ts --network ropsten
```

### Thriftor simulation and Testing
This will deploy the smart contract to a loacal hardhat blockchain and run all its functions succesfully
```bash
yarn hardhat test test/traveloor.ts
```


## License

This project is licensed under the [MIT license](LICENSE).
