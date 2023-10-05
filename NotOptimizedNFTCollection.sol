// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable2Step.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/**
 * @title NotOptimizedCollection
 * @dev This contract is for creating an NFT collection using ERC721Enumerable. 
 * It initializes the collection with 20 NFT items upon deployment.
 */
contract NotOptimizedNFTCollection is ERC721Enumerable, Ownable2Step {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;  // Counter for generating unique token IDs

    /**
     * @notice Creates an instance of NotOptimizedCollection and mints 20 NFTs to the contract deployer.
     */
    constructor() ERC721("NotOptimizedCollection", "NONC") {
        // Initialize the collection with 20 NFT items
        for (uint i = 0; i < 20; i++) {
            _mintNFT(msg.sender);
        }
    }

    /**
     * @dev Internal function to mint a new NFT.
     * @param recipient The address that will receive the minted NFT.
     */
    function _mintNFT(address recipient) internal {
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        _mint(recipient, tokenId);
    }
}

/**
 * @title PrimeChecker
 * @dev This contract contains utility functions to check for prime numbers 
 * and to count the number of NFTs with prime token IDs owned by a specific address.
 */
contract PrimeChecker {
    /**
     * @notice Checks if the given number is a prime number.
     * @param number The number to check.
     * @return True if the number is prime, otherwise false.
     */
    function isPrime(uint256 number) public pure returns (bool) {
        if (number < 2) {
            return false;
        }
        for (uint256 i = 2; i * i <= number; i++) {
            if (number % i == 0) {
                return false;
            }
        }
        return true;
    }

    /**
     * @notice Counts the number of NFTs with prime token IDs owned by the given address.
     * @param nftContract The address of the ERC721Enumerable contract.
     * @param owner The address of the token owner.
     * @return The number of NFTs with prime token IDs.
     */
    function primeTokensOwned(NotOptimizedNFTCollection nftContract, address owner) public view returns (uint256) {
        uint256 count = 0;
        uint256 totalOwned = nftContract.balanceOf(owner);

        for (uint256 index = 0; index < totalOwned; index++) {
            uint256 tokenId = nftContract.tokenOfOwnerByIndex(owner, index);
            if (isPrime(tokenId)) {
                count++;
            }
        }
        
        return count;
    }
}
