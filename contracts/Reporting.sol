// SPDX-License-Identifier: MIT
// To Init the contract use this parameter [Remix]
// [0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db],  [0x617F2E2fD72FD9D5503197092aC168c91465E7f2, 0x17F6AD8Ef982297579C203069C1DbfFE4348c372, 0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678, 0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7, 0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C]

// To Init with only verifier [Remix]
// [0x617F2E2fD72FD9D5503197092aC168c91465E7f2, 0x17F6AD8Ef982297579C203069C1DbfFE4348c372, 0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678, 0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7, 0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C]
// [{verifierAddress: 0x617F2E2fD72FD9D5503197092aC168c91465E7f2, email: "rafi.ramadhan27@gmail.com"}, {verifierAddress: 0x17F6AD8Ef982297579C203069C1DbfFE4348c372, email: "rafi.ramadhan27+1@gmail.com"}, {verifierAddress: 0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678, email: "rafi.ramadhan27+2@gmail.com"}, {verifierAddress: 0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7, email: "rafi.ramadhan27+3@gmail.com"}, {verifierAddress: 0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C, email: "rafi.ramadhan27+4@gmail.com"}]
// address: [0x617F2E2fD72FD9D5503197092aC168c91465E7f2, 0x17F6AD8Ef982297579C203069C1DbfFE4348c372,0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678,0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7,0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C, 0x0A098Eda01Ce92ff4A4CCb7A4fFFb5A43EBC70DC, 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c]
// email: ["rafi.ramadhan27@gmail.com", "rafi.ramadhan27+c372@gmail.com", "rafi.ramadhan27+1678@gmail.com", "rafi.ramadhan27+1Ff7@gmail.com", "rafi.ramadhan27+454c@gmail.com", "rafi.ramadhan27+70DC@gmail.com", "rafi.ramadhan27+733c@gmail.com"]
// single line : [0x617F2E2fD72FD9D5503197092aC168c91465E7f2, 0x17F6AD8Ef982297579C203069C1DbfFE4348c372,0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678,0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7,0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C, 0x0A098Eda01Ce92ff4A4CCb7A4fFFb5A43EBC70DC, 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c], ["rafi.ramadhan27@gmail.com", "rafi.ramadhan27+c372@gmail.com", "rafi.ramadhan27+1678@gmail.com", "rafi.ramadhan27+1Ff7@gmail.com", "rafi.ramadhan27+454c@gmail.com", "rafi.ramadhan27+70DC@gmail.com", "rafi.ramadhan27+733c@gmail.com"]

// To Init the contract use this parameter [Hardhat]
// [0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 0x70997970C51812dc3A010C7d01b50e0d17dc79C8, 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC], [0x976EA74026E726554dB657fA54763abd0C3a0aa9, 0x14dC79964da2C08b23698B3D3cc7Ca32193d9955, 0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f, 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720, 0xBcd4042DE499D14e55001CcbB24a551F3b954096]

// To init with only verifier [Hardhat]
// [0x976EA74026E726554dB657fA54763abd0C3a0aa9, 0x14dC79964da2C08b23698B3D3cc7Ca32193d9955, 0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f, 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720, 0xBcd4042DE499D14e55001CcbB24a551F3b954096]

pragma solidity ^0.8.18;

import "hardhat/console.sol";

contract Reporting {
    struct Verifier {
        address verifierAddress;
        string verifierEmail;
    }

    address public authority;
    address public organization;
    mapping(address => Verifier) public verifiers;
    address[] public verifierAddresses;
    mapping(address => bool) public signatures;
    mapping(address => bool) public selectedVerifiers;
    mapping(address => bool) public mismatch;
    mapping(address => uint256) public reportedTokens;
    mapping(address => string) public docHashes;
    bool public transactionActive;
    bool public transactionFinished;
    bool public transactionRejected;
    string public rejectionMessage;
    uint256 private constant INITIAL_VERIFIER_COUNT = 7;

    event SignatureAdded(address indexed signer);
    event TransactionFinished();
    event TransactionRejected(string message);
    event ConsoleLoguint256(uint256[] message);
    event ConsoleLogstring(string message);
    event ConsoleLogarray(string[] message);
    event ConsoleLogaddress(address[] message);
    event VerifierRejected(address verifier);
    event VerifierReplaced(
        address indexed oldVerifier,
        address indexed newVerifier
    );

    constructor(
        address[] memory _verifierAddresses,
        string[] memory _verifierEmails
    ) {
        require(
            _verifierAddresses.length >= 5,
            "Insufficient number of verifiers"
        );
        require(
            _verifierAddresses.length == _verifierEmails.length,
            "Mismatched verifier data"
        );

        for (uint256 i = 0; i < _verifierAddresses.length; i++) {
            Verifier memory verifier = Verifier({
                verifierAddress: _verifierAddresses[i],
                verifierEmail: _verifierEmails[i]
            });
            verifiers[_verifierAddresses[i]] = verifier;
            verifierAddresses.push(_verifierAddresses[i]);
        }

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

    function initialize(
        uint256 _reportedToken,
        string memory _docHash,
        uint256 _storedUsage
    ) external returns (string memory, string memory) {
        require(organization == address(0), "Contract already initialized");
        organization = msg.sender;
        transactionActive = true;

        // Automatically select random verifiers and add the organization's signature
        _selectRandomVerifiers();
        reportedTokens[organization] = _reportedToken;
        docHashes[organization] = _docHash;
        signatures[organization] = true;
        if (_reportedToken == _storedUsage) {
            mismatch[organization] = true;
        } else {
            mismatch[organization] = false;
        }
        emit SignatureAdded(organization);

        address[] memory selectedVerifierAddresses;
        string[] memory selectedVerifierEmails;
        (
            selectedVerifierAddresses,
            selectedVerifierEmails
        ) = _getAllSelectedVerifiers();

        string memory addressez = arrayToString(selectedVerifierAddresses);
        string memory emailz = arrayToString(selectedVerifierEmails);
        emit ConsoleLogaddress(selectedVerifierAddresses);
        emit ConsoleLogarray(selectedVerifierEmails);

        return (addressez, emailz);
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

    function rejectInvolvement() public returns (string memory, string memory) {
        require(selectedVerifiers[msg.sender], "Not a selected verifier");

        // Remove the rejecting verifier from the selected verifier list
        selectedVerifiers[msg.sender] = false;

        // Reselect new random verifiers
        uint256 newIndex = _generateRandomNumber(0, verifierAddresses.length);
        address newVerifierAddress = verifierAddresses[newIndex];
        selectedVerifiers[newVerifierAddress] = true;
        emit VerifierReplaced(msg.sender, newVerifierAddress);

        // Emit an event to indicate that a verifier has rejected their involvement
        emit VerifierRejected(msg.sender);
        address[] memory selectedVerifierAddresses;
        string[] memory selectedVerifierEmails;
        (
            selectedVerifierAddresses,
            selectedVerifierEmails
        ) = _getAllSelectedVerifiers();

        emit ConsoleLogaddress(selectedVerifierAddresses);
        emit ConsoleLogarray(selectedVerifierEmails);

        return (
            arrayToString(selectedVerifierAddresses),
            arrayToString(selectedVerifierEmails)
        );
    }

    function areSignaturesComplete() public view returns (bool) {
        uint256 count = 0;

        if (signatures[organization]) {
            count++;
        }

        for (uint256 i = 0; i < verifierAddresses.length; i++) {
            address verifierAddress = verifierAddresses[i];
            if (
                selectedVerifiers[verifierAddress] &&
                signatures[verifierAddress]
            ) {
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
            address verifierAddress = verifierAddresses[selectedIndices[i]];
            selectedVerifiers[verifierAddress] = true;
        }
    }

    function _getAllSelectedVerifiers()
        private
        view
        returns (address[] memory, string[] memory)
    {
        address[] memory verifiersArray = new address[](
            verifierAddresses.length
        );
        string[] memory verifierEmailsArray = new string[](
            verifierAddresses.length
        );
        uint256 count = 0;

        for (uint256 i = 0; i < verifierAddresses.length; i++) {
            if (selectedVerifiers[verifierAddresses[i]]) {
                verifiersArray[count] = verifierAddresses[i];
                verifierEmailsArray[count] = verifiers[verifierAddresses[i]]
                    .verifierEmail;
                count++;
            }
        }

        address[] memory selectedVerifiersArray = new address[](count);
        string[] memory selectedVerifierEmailsArray = new string[](count);
        for (uint256 i = 0; i < count; i++) {
            selectedVerifiersArray[i] = verifiersArray[i];
            selectedVerifierEmailsArray[i] = verifierEmailsArray[i];
        }

        return (selectedVerifiersArray, selectedVerifierEmailsArray);
    }

    function _selectRandomIndices(uint256 count)
        private
        view
        returns (uint256[] memory)
    {
        uint256[] memory selected = new uint256[](count);
        address[] memory verifierAddressesArray = verifierAddresses;
        uint256[] memory available = new uint256[](
            verifierAddressesArray.length
        );

        for (uint256 i = 0; i < verifierAddressesArray.length; i++) {
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

    function arrayToString(address[] memory arr)
        private
        pure
        returns (string memory)
    {
        bytes memory str = new bytes(arr.length * 40); // Assuming address length of 40
        uint256 index = 0;

        for (uint256 i = 0; i < arr.length; i++) {
            bytes20 addressBytes = bytes20(arr[i]);
            for (uint256 j = 0; j < 20; j++) {
                uint8 char = uint8(addressBytes[j]);
                uint8 hi = uint8(char / 16);
                uint8 lo = uint8(char - 16 * hi);
                str[index++] = charToHex(hi);
                str[index++] = charToHex(lo);
            }
        }

        return string(str);
    }

    function arrayToString(string[] memory arr)
        private
        pure
        returns (string memory)
    {
        string memory str = "";

        for (uint256 i = 0; i < arr.length; i++) {
            if (i > 0) {
                str = string(abi.encodePacked(str, ", ", arr[i]));
            } else {
                str = arr[i];
            }
        }

        return str;
    }

    function charToHex(uint8 char) private pure returns (bytes1) {
        if (char < 10) {
            return bytes1(uint8(bytes1("0")) + char);
        } else {
            return bytes1(uint8(bytes1("a")) + char - 10);
        }
    }
}
