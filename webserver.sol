// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
// these imports will come from `@tevm/solidity-serve`
import "./IHttpRequest.sol";
import "./IHttpResponse.sol";
import "./ServerInfo.sol";

contract HelloWorldServer {
    ServerInfo.Info public serverInfo;
    IERC721 public nftContract;

    // ServerInfo is always passed in first followed by user provided args in order
    constructor(ServerInfo.Info memory _serverInfo, IERC721 _nftContract) {
        serverInfo = _serverInfo;
        nftContract = _nftContract;
    }

    // this creates a hello world endpoint
    function helloWorld(address requestAddress, address responseAddress) external {
        IHttpRequest request = IHttpRequest(requestAddress);
        IHttpResponse response = IHttpResponse(responseAddress);

        response.setStatus(200);
        response.setHeader("Content-Type", "text/plain");
        response.setBody("Hello, World!");
        response.send();
    }

    // this creates a balanceOf import
    function balanceOf(address requestAddress, address responseAddress) external {
        IHttpRequest request = IHttpRequest(requestAddress);
        IHttpResponse response = IHttpResponse(responseAddress);

        string memory paramAddress = request.params("address");
        address wallet = parseAddr(paramAddress);
        uint256 balance = nftContract.balanceOf(wallet);

        response.setStatus(200);
        response.setHeader("Content-Type", "application/json");
        response.setBody(uintToStr(balance));
        response.send();
    }

    function mint(address requestAddress, address responseAddress) external {
        IHttpRequest request = IHttpRequest(requestAddress);
        IHttpResponse response = IHttpResponse(responseAddress);

        // Handle minting logic here
        response.setStatus(200);
        response.setHeader("Content-Type", "text/plain");
        response.setBody("Minting not implemented yet");
        response.send();
    }
}
