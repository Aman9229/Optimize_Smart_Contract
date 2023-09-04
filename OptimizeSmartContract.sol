// SPDX-License-Identifier: UNLINCECED
pragma solidity ^0.8.4;


// normal transaction gas fee.21000(basic ) 
// but all smart contract is not consume 21000 it will above



//  1 .Opcode 


contract operater{
  function multiply(uint x) public pure returns(uint){
      return x*2;    //  execution cost 761 gas      
    // using bit shifting operator ( return x<<2 ) execution cost  611  
    // and save 150 gas per transaction.  

  }

  function division (uint x) public pure returns(uint){
    return x/2;   // execution cost 854 gas     
    
      // using bit shifting operator  return x>>2   execution cost 589   
      // and save 265  gas per transaction. 
  }
}



// 2.  Type of Transaction


// only normal transaction it cost gas 21000 & extra data consume extra gas 
contract consume{
  function pay()external {   // no of opcode is large 

  }
  function pay1()external payable {  // no of opcode is less( payable function is less cost of gas )  

  }
}



// 3. Memory



// always aviod to use state variable because state variable directly stored in blockchain and consume large ammount of gases 
contract store{
  
function remainder(uint8 x) public pure returns(uint8){   //execution cost  785 gas 
  return x/3; 
}
}


contract store1{
  uint8 p=3;
function remainder(uint8 x) public view returns(uint8){   //execution cost  2921 gas 
  return x/p; 
}
}  //   almost save 2136 gas  




// 3.1
  contract storagecontract {
    uint8 p=32;
    //uint256 k=25;  //  transaction cost  89641 gas 
  }

contract storagecontract1 {
   uint256 k=25;  // transaction cost  89240 gas 
  }
// save 401 gas because in ethereum allot 256 bits 
// 32 bytes 32*8=256
//  256-8= 248 is remainig bits 



// 3.2 Variable packing 

 contract variable_packing{ //  transaction cost 135378 gas 
   uint128 a=89;
   uint256 b=35;
   uint128 c=25;
   
 }
 contract variable_packing_1{   //transaction cost 113528 gas 
   uint128 a=89;
   uint128 c=25;
   uint256 b=35;
   
 } // save 21850 gas in variable packing 
  // no of opcodes is less gas consumption is less



  // 4. State Change


  // always using local variables

contract optimize_smart_contract_state_change{
    uint[] public array; // both are state variable if we wants to utilize smart contract avoid decleare state variable.
    uint public sum;
    constructor(){
        array=[1,2,3,4,5,6,7];
    }

    function unchecked_i(uint x ) private pure returns (uint){
      unchecked{return x+1;}   // unchecked function reduced the gas cost

    }
    function lopp()external{
        uint _sum;                       
        uint[] memory _array =array;      // local variable here value save in local variable after loop will be end value will stored in state variable.
         for(uint i=0; i<array.length; unchecked_i ){   //for(uint i=0; i<array.length; i++ ) it will cost extra gas 
        //_sum=_sum + array[i];
        _sum=_sum + _array[i];
      }
        sum =_sum;
    }
}