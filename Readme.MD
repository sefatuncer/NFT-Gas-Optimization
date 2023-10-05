# NFT Enumerable Contracts Repository with Gas Optimization

This repository showcases two distinct implementations of an NFT ecosystem built on the ERC721Enumerable standard. One implementation focuses on a straightforward approach, while the other has been refined for gas optimization.

## Features

1. **ERC721Enumerable NFT Collection:**
    - A new NFT collection consisting of 20 unique items is created, where token IDs range from 1 to 20 (inclusive).

2. **Prime Token ID Counter:**
    - A separate smart contract, `PrimeChecker`, identifies the ownership of prime-numbered TokenIDs for a specific address.
    - If an address owns token IDs 10, 11, 12, and 13, for example, it returns the count of prime token IDs - which would be 2 in this scenario.
    - Prime values aren't hardcoded, ensuring scalability even beyond the 20-token limit.

## Implementations

1. **Standard Implementation (`NotOptimizedNFTCollection`):**
    - This is a basic approach without specific gas-optimization measures.
    - The `Counters` library from OpenZeppelin is employed to manage token ID generation.
  
2. **Gas-Optimized Implementation (`OptimizedNFTCollection`):**
    - An optimized approach to reduce gas consumption.
    - The code has been restructured to optimize prime number checks, especially for larger numbers.
    - Utilizes a more efficient method for generating unique token IDs.

## Installation & Deployment

1. **Dependencies:**
   - Ensure you have the required OpenZeppelin contracts installed.
   
2. **Deployment:**
   - Deploy the respective contracts using your preferred method or platform.
