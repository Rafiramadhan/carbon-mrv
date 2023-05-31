//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.9;

// We import this library to be able to use console.log
import "hardhat/console.sol";

contract Monitoring {
    struct CompanyData {
        uint256 capAmount;
        uint256 reportingYear;
    }

    mapping(address => mapping(uint256 => CompanyData[])) private dataByCompanyAndYear;

    event DataInserted(address indexed companyId, uint256 indexed capAmount, uint256 indexed reportingYear);

    function insertData(address _companyId, uint256 _capAmount, uint256 _reportingYear) external {
        require(_capAmount > 0, "Cap amount must be greater than zero");

        CompanyData[] storage companyData = dataByCompanyAndYear[_companyId][_reportingYear];
        companyData.push(CompanyData(_capAmount, _reportingYear));

        emit DataInserted(_companyId, _capAmount, _reportingYear);
    }

    function getTotalCapByYear(address _companyId, uint256 _year) external view returns (uint256) {
        CompanyData[] storage companyData = dataByCompanyAndYear[_companyId][_year];
        uint256 totalCap = 0;

        for (uint256 i = 0; i < companyData.length; i++) {
            totalCap += companyData[i].capAmount;
        }

        return totalCap;
    }
}
