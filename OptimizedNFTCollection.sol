// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable2Step.sol";

/**
 * @title OptimizedNFTCollection
 * @dev This contract is for creating an optimized NFT collection using ERC721Enumerable. 
 * It initializes the collection with 20 NFT items upon deployment.
 */
contract OptimizedNFTCollection is ERC721Enumerable, Ownable2Step {
    uint256 private _currentTokenId = 0;  // Optimized counter for generating unique token IDs

    /**
     * @notice Creates an instance of MyOptimizedNFTCollection and mints 20 NFTs to the contract deployer.
     */
    constructor() ERC721("OptimizedNFTCollection", "ONC") {
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
        _currentTokenId++;
        _mint(recipient, _currentTokenId);
    }
}

/**
 * @title PrimeChecker
 * @dev This contract contains optimized utility functions to check for prime numbers 
 * and to count the number of NFTs with prime token IDs owned by a specific address.
 */
contract PrimeChecker {
    /**
     * @notice Optimized function to check if the given number is a prime number.
     * @param number The number to check.
     * @return True if the number is prime, otherwise false.
     */
    function isPrime(uint256 number) public pure returns (bool) {
        if (number < 2) {
            return false;
        }
        if (number == 2 || number == 3) {
            return true;
        }
        if (number % 2 == 0 || number % 3 == 0) {
            return false;
        }
        // Most prime numbers are in the form 6*n+1 or 6*n-1
        // This for loop is enough for small numbers
        for (uint256 i = 5; i * i <= number; i += 6) {
            if (number % i == 0 || number % (i + 2) == 0) {
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
    function primeTokensOwned(OptimizedNFTCollection nftContract, address owner) public view returns (uint256) {
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
    // If we use very large numbers; for gas consumption optimization, 
    // Calculate the square root of number via a function instead of i * i 
    // function isPrime(uint256 number) public pure returns (bool) {
    //     if (number < 2) return false;
    //     if (number == 2 || number == 3) return true;
    //     if (number % 2 == 0 || number % 3 == 0) return false;
        
    //     uint256 sqrtLimit = uint256(sqrt(number));
        
    //     for (uint256 i = 5; i <= sqrtLimit; i += 6) {
    //         if (number % i == 0 || number % (i + 2) == 0) return false;
    //     }
    //     return true;
    // }

    // function sqrt(uint x) public pure returns (uint y) {
    //     uint z = (x + 1) / 2;
    //     y = x;
    //     while (z < y) {
    //         y = z;
    //         z = (x / z + z) / 2;
    //     }
    // }