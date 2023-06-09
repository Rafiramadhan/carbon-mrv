/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import type { Provider, TransactionRequest } from "@ethersproject/providers";
import type { PromiseOrValue } from "../../common";
import type {
  Monitoring,
  MonitoringInterface,
} from "../../Monitoring.sol/Monitoring";

const _abi = [
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "companyId",
        type: "address",
      },
      {
        indexed: true,
        internalType: "uint256",
        name: "capAmount",
        type: "uint256",
      },
      {
        indexed: true,
        internalType: "uint256",
        name: "reportingYear",
        type: "uint256",
      },
    ],
    name: "DataInserted",
    type: "event",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_companyId",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "_year",
        type: "uint256",
      },
    ],
    name: "getTotalCapByYear",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_companyId",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "_capAmount",
        type: "uint256",
      },
      {
        internalType: "uint256",
        name: "_reportingYear",
        type: "uint256",
      },
    ],
    name: "insertData",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];

const _bytecode =
  "0x608060405234801561001057600080fd5b5061057b806100206000396000f3fe608060405234801561001057600080fd5b50600436106100365760003560e01c8063205ed53e1461003b578063639e819f1461006b575b600080fd5b6100556004803603810190610050919061030b565b610087565b604051610062919061035a565b60405180910390f35b61008560048036038101906100809190610375565b61013c565b005b6000806000808573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600084815260200190815260200160002090506000805b8280549050811015610130578281815481106100fe576100fd6103c8565b5b9060005260206000209060020201600001548261011b9190610426565b915080806101289061045a565b9150506100df565b50809250505092915050565b6000821161017f576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161017690610525565b60405180910390fd5b60008060008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600083815260200190815260200160002090508060405180604001604052808581526020018481525090806001815401808255809150506001900390600052602060002090600202016000909190919091506000820151816000015560208201518160010155505081838573ffffffffffffffffffffffffffffffffffffffff167f77878ec0331051081e8d9c4ee250e344fe5fa4b8fd5a618408c071919c48e50b60405160405180910390a450505050565b600080fd5b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b60006102a282610277565b9050919050565b6102b281610297565b81146102bd57600080fd5b50565b6000813590506102cf816102a9565b92915050565b6000819050919050565b6102e8816102d5565b81146102f357600080fd5b50565b600081359050610305816102df565b92915050565b6000806040838503121561032257610321610272565b5b6000610330858286016102c0565b9250506020610341858286016102f6565b9150509250929050565b610354816102d5565b82525050565b600060208201905061036f600083018461034b565b92915050565b60008060006060848603121561038e5761038d610272565b5b600061039c868287016102c0565b93505060206103ad868287016102f6565b92505060406103be868287016102f6565b9150509250925092565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601160045260246000fd5b6000610431826102d5565b915061043c836102d5565b9250828201905080821115610454576104536103f7565b5b92915050565b6000610465826102d5565b91507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff8203610497576104966103f7565b5b600182019050919050565b600082825260208201905092915050565b7f43617020616d6f756e74206d7573742062652067726561746572207468616e2060008201527f7a65726f00000000000000000000000000000000000000000000000000000000602082015250565b600061050f6024836104a2565b915061051a826104b3565b604082019050919050565b6000602082019050818103600083015261053e81610502565b905091905056fea26469706673582212206eb97f4c99ae04a1ee1edcf3f4edc6c56f62e48b8a337b0150d6ae6d9375fd3164736f6c63430008120033";

type MonitoringConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: MonitoringConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class Monitoring__factory extends ContractFactory {
  constructor(...args: MonitoringConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override deploy(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<Monitoring> {
    return super.deploy(overrides || {}) as Promise<Monitoring>;
  }
  override getDeployTransaction(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(overrides || {});
  }
  override attach(address: string): Monitoring {
    return super.attach(address) as Monitoring;
  }
  override connect(signer: Signer): Monitoring__factory {
    return super.connect(signer) as Monitoring__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): MonitoringInterface {
    return new utils.Interface(_abi) as MonitoringInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): Monitoring {
    return new Contract(address, _abi, signerOrProvider) as Monitoring;
  }
}
