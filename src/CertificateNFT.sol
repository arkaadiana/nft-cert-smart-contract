// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract CertificateNFT is ERC721URIStorage, Ownable {
    uint256 private _certificateCounter;

    error TransferNotAllowed();
    error ApprovalNotAllowed();
    error ApprovalForAllNotAllowed();

    event NFTMinted(address indexed recipient, uint256 certificateId, string metadataURI);

    constructor() ERC721("Putu Arka Adiana", "PAA") {}

    function mintingNFT(string memory base64Image) external onlyOwner {
        uint256 certificateId = ++_certificateCounter;

        string memory metadataURI = _generateTokenURI(_generateMetadata(base64Image, certificateId));
        _mint(msg.sender, certificateId);
        _setTokenURI(certificateId, metadataURI);

        emit NFTMinted(msg.sender, certificateId, metadataURI);
    }

    function _generateMetadata(string memory base64Image, uint256 certificateId) private pure returns (string memory) {
        string memory imageUrl = "https://ipfs.io/ipfs/bafkreigxnhhmoeyg5vjfcrlr4yluostuxuivpehn77i5uzt4uc4e5zdp2i";

        bytes memory metadata = abi.encodePacked(
            "{",
            '"name": "Certificate NFT Arka #',
            Strings.toString(certificateId),
            '", ',
            '"description": "This Certificate NFT is a digital recognition awarded for achievements or participation in an event, project, or activity.", ',
            '"image_url": "',
            imageUrl,
            base64Image,
            '"',
            "}"
        );

        return string(metadata);
    }

    function _generateTokenURI(string memory json) private pure returns (string memory) {
        string memory base64Json = Base64.encode(bytes(json));
        return string(abi.encodePacked("data:application/json;base64,", base64Json));
    }

    function transferFrom(address, address, uint256) public pure override(ERC721, IERC721) {
        revert TransferNotAllowed();
    }

    function approve(address, uint256) public pure override(ERC721, IERC721) {
        revert ApprovalNotAllowed();
    }

    function setApprovalForAll(address, bool) public pure override(ERC721, IERC721) {
        revert ApprovalForAllNotAllowed();
    }
}
