//SPDX-License-Identifier:MIT

pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodeNft is ERC721 {
    uint256 private s_tokenCounter;
    string private s_sapSvgImageUri;
    string private s_happySvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory sadSvgImageUri,
        string memory happySvgImageUri
    ) ERC721("MoodNft", "MN") {
        s_tokenCounter = 0;
        s_sapSvgImageUri = sadSvgImageUri;
        s_happySvgImageUri = happySvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns(string memory) {
        return "data:application/json;base64,";
    }
        

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI;

        if (s_tokenIdToMood[tokenId] == Mood.HAPPEY) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sapSvgImageUri;
        }

        return 
        string (
        abi.encodePacked(

        _baseURI();

        Base64.encode(
            bytes(
                abi.encodePacked(
                    '{"name": "',
                    name(),
                    '", "description": "An NFT that reflects the owner\'s mood.", "attributes": [{"trait_type": "moodiness", "value": 100}], "image": "',
                    imageURI,
                    '"}'
                )
            )
        )));
    }
}
