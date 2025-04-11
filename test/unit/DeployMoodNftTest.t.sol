//SPDX-License-Identifier:MIT

pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft public deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(svg));

        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }

    function testConvertSvgToUri() public view {
        string
            memory expectedUri = "data:image/svg+xml;base64,Cjxzdmcgdmlld0JveD0iMCAwIDIwMCAyMDAiIHdpZHRoPSI0MDAiICBoZWlnaHQ9IjQwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48Y2lyY2xlIGN4PSIxMDAiIGN5PSIxMDAiIGZpbGw9InllbGxvdyIgcj0iNzgiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iMyIvPjxnIGNsYXNzPSJleWVzIj48Y2lyY2xlIGN4PSI3MCIgY3k9IjgyIiByPSIxMiIvPjxjaXJjbGUgY3g9IjEyNyIgY3k9IjgyIiByPSIxMiIvPjwvZz48cGF0aCBkPSJtMTM2LjgxIDExNi41M2MuNjkgMjYuMTctNjQuMTEgNDItODEuNTItLjczIiBzdHlsZT0iZmlsbDpub25lOyBzdHJva2U6IGJsYWNrOyBzdHJva2Utd2lkdGg6IDM7Ii8+PC9zdmc+Cg==";
        string
            memory svg = '<svg viewBox="0 0 200 200" width="400"  height="400" xmlns="http://www.w3.org/2000/svg"><circle cx="100" cy="100" fill="yellow" r="78" stroke="black" stroke-width="3"/><g class="eyes"><circle cx="70" cy="82" r="12"/><circle cx="127" cy="82" r="12"/></g><path d="m136.81 116.53c.69 26.17-64.11 42-81.52-.73" style="fill:none; stroke: black; stroke-width: 3;"/></svg>';

        string memory actualUri = deployer.svgToImageURI(svg);
        assert(
            keccak256(abi.encodePacked(expectedUri)) ==
                keccak256(abi.encodePacked(actualUri))
        );
    }
}
