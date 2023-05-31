import React, { useEffect, useState, useRef } from 'react';
import { useNavigate, withRouter } from 'react-router-dom'
import { ethers } from 'ethers';

export const Monitoring = () => {
  const [reportingContract, setReportingContract] = useState(null);
  const [usageData, setUsageData] = useState([]);
  const [message, setMessage] = useState(''); // State for success message
  const [file, setFile] = useState();
  const fileUpload = useRef(null);
  // const navigate = useNavigate();
  // const history = useHistory();

  useEffect(() => {
    // Connect to the Reporting contract
    const connectToContract = async () => {
      try {
        // Connect to the local Ethereum provider
        const provider = new ethers.providers.JsonRpcProvider();

        // Load the deployed Reporting contract
        const contractAddress = 'YOUR_REPORTING_CONTRACT_ADDRESS';
        const contractAbi = ['ABI_OF_YOUR_REPORTING_CONTRACT'];
        const reportingContract = new ethers.Contract(contractAddress, contractAbi, provider);

        // Set the connected contract instance
        setReportingContract(reportingContract);
      } catch (error) {
        console.error('Failed to connect to the Reporting contract:', error);
      }
    };

    connectToContract();
  }, []);

  // Function to handle file upload
  const handleFileUpload = async (event) => {
    event.preventDefault();

    const file = event.target.files[0];
    setFile(file);
    console.log('file --> ', file)

    if (file) {
      const reader = new FileReader();

      reader.onload = async (e) => {
        const csvContent = e.target.result;
        const usageValue = processCsvData(csvContent); // Process the CSV data and get the usage value
        console.log('csvContent --> ', csvContent)
        console.log('usageValue --> ', usageValue)

        // Show success message
        setMessage(`File upload success, the value is ${usageValue}, redirecting back in 5,4,3,2,1`);

        // Redirect back to the upload page after 5 seconds
        setTimeout(() => {
          setMessage('');
          fileUpload.current.reset();
        }, 5000);
      };

      reader.readAsText(file);
    }
  };

  // Function to process CSV data and extract values from "usage" column
  const processCsvData = (csvContent) => {
    const lines = csvContent.split('\n');
    let usage = '';
  
    if (lines.length > 1) {
      const headerLine = lines[0] ? lines[0].trim() : '';
      const headerColumns = headerLine.split(',');
  
      const usageColumnIndex = headerColumns.findIndex((column) =>
        column.toLowerCase().trim() === 'usage'
      );
  
      if (usageColumnIndex !== -1) {
        const dataLine = lines[1] ? lines[1].trim() : '';
        const dataColumns = dataLine.split(',');
  
        if (dataColumns.length > usageColumnIndex) {
          usage = dataColumns[usageColumnIndex].trim();
        }
      }
    }
  
    setUsageData(usage);
    return usage;
  };

  return (
    <div>
      <h1>Upload Emission Usage</h1>
      {message && <p>{message}</p>}
      <form ref={fileUpload}>
      {/* //     File Upload */}
       <input type="file" accept=".csv" onChange={handleFileUpload} />
        {/* <input type="file" onChange={handleFileUpload} /> */}
      </form>
    </div>
  );
};

export default Monitoring;