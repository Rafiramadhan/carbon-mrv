// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// To Init the contract use this parameter [Remix]
// [0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db],  [0x617F2E2fD72FD9D5503197092aC168c91465E7f2, 0x17F6AD8Ef982297579C203069C1DbfFE4348c372, 0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678, 0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7, 0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C]

// To Init with only verifier [Remix]
// [0x617F2E2fD72FD9D5503197092aC168c91465E7f2, 0x17F6AD8Ef982297579C203069C1DbfFE4348c372, 0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678, 0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7, 0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C]

// To Init the contract use this parameter [Hardhat] 
// [0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 0x70997970C51812dc3A010C7d01b50e0d17dc79C8, 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC], [0x976EA74026E726554dB657fA54763abd0C3a0aa9, 0x14dC79964da2C08b23698B3D3cc7Ca32193d9955, 0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f, 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720, 0xBcd4042DE499D14e55001CcbB24a551F3b954096]

// To init with only verifier [Hardhat]
// [0x976EA74026E726554dB657fA54763abd0C3a0aa9, 0x14dC79964da2C08b23698B3D3cc7Ca32193d9955, 0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f, 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720, 0xBcd4042DE499D14e55001CcbB24a551F3b954096]

contract Reporting {
    address public authority;
    address public organization;
    address[] public verifiers;
    mapping(address => bool) public signatures;
    mapping(address => bool) public selectedVerifiers;
    mapping(address => uint256) public reportedTokens;
    mapping(address => string) public docHashes;
    bool public transactionActive;
    bool public transactionFinished;
    bool public transactionRejected;
    string public rejectionMessage;

    event SignatureAdded(address indexed signer);
    event TransactionFinished();
    event TransactionRejected(string message);

    constructor(address[] memory _verifiers) {
        require(_verifiers.length >= 5, "Insufficient number of verifiers");

        verifiers = _verifiers;
        authority = msg.sender;
        transactionActive = false;
        transactionFinished = false;
        transactionRejected = false;
    }

    modifier onlyOrganization() {
        require(msg.sender == organization, "Unauthorized");
        _;
    }

    modifier onlyAuthority() {
        require(msg.sender == authority, "Unauthorized");
        _;
    }

    modifier transactionActiveOnly() {
        require(transactionActive, "Transaction not active");
        _;
    }

    modifier transactionNotFinished() {
        require(!transactionFinished, "Transaction already finished");
        _;
    }

    modifier transactionNotRejected() {
        require(!transactionRejected, "Transaction already rejected");
        _;
    }

    function initialize(uint256 _reportedToken, string memory _docHash)
        external
    {
        require(organization == address(0), "Contract already initialized");
        organization = msg.sender;
        transactionActive = true;

        // Automatically select random verifiers and add the organization's signature
        _selectRandomVerifiers();
        reportedTokens[organization] = _reportedToken;
        docHashes[organization] = _docHash;
        signatures[organization] = true;
        emit SignatureAdded(organization);
    }

    function addSignature()
        external
        transactionActiveOnly
        transactionNotFinished
    {
        require(msg.sender != address(0), "Invalid signer");
        require(
            selectedVerifiers[msg.sender] || msg.sender == authority,
            "Unauthorized signer"
        );
        require(signatures[msg.sender] == false, "Signature already added");

        signatures[msg.sender] = true;
        emit SignatureAdded(msg.sender);
    }

    function finishTransaction() external onlyAuthority transactionActiveOnly {
        require(!transactionFinished, "Transaction already finished");

        transactionFinished = true;
        transactionActive = false;
        emit TransactionFinished();
    }

    function rejectTransaction(string memory message)
        external
        onlyOrganization
        transactionActiveOnly
    {
        require(!transactionFinished, "Transaction already finished");
        require(!transactionRejected, "Transaction already rejected");

        transactionRejected = true;
        rejectionMessage = message;
        emit TransactionRejected(message);
    }

    function areSignaturesComplete() public view returns (bool) {
        uint256 count = 0;

        if (signatures[organization]) {
            count++;
        }

        for (uint256 i = 0; i < verifiers.length; i++) {
            if (selectedVerifiers[verifiers[i]] && signatures[verifiers[i]]) {
                count++;
            }
        }

        return count >= 5;
    }

    function isVerifierSelected()
        public
        view
        returns (
            bool,
            address,
            uint256,
            string memory
        )
    {
        if (selectedVerifiers[msg.sender]) {
            return (
                true,
                organization,
                reportedTokens[organization],
                docHashes[organization]
            );
        }
        return (false, address(0), 0, "");
    }

    function _selectRandomVerifiers() private {
        uint256[] memory selectedIndices = _selectRandomIndices(3);

        for (uint256 i = 0; i < selectedIndices.length; i++) {
            selectedVerifiers[verifiers[selectedIndices[i]]] = true;
        }
    }

    function _selectRandomIndices(uint256 count)
        private
        view
        returns (uint256[] memory)
    {
        uint256[] memory selected = new uint256[](count);
        uint256[] memory available = new uint256[](verifiers.length);

        for (uint256 i = 0; i < verifiers.length; i++) {
            available[i] = i;
        }

        for (uint256 i = 0; i < count; i++) {
            uint256 index = _generateRandomNumber(i, available.length);
            selected[i] = available[index];

            available[index] = available[available.length - 1];

            uint256[] memory newAvailable = new uint256[](available.length - 1);
            for (uint256 j = 0; j < available.length - 1; j++) {
                newAvailable[j] = available[j];
            }
            available = newAvailable;
        }

        return selected;
    }

    function _generateRandomNumber(uint256 seed, uint256 max)
        private
        view
        returns (uint256)
    {
        uint256 randomHash = uint256(
            keccak256(abi.encodePacked(block.difficulty, block.timestamp, seed))
        );
        return randomHash % max;
    }
}
