// SPDX-License-Identifier: MIT

pragma solidity 0.8.3;

abstract contract Vehicle{

    function move () external pure virtual returns(string memory);

    function stop () external pure returns (string memory){

        return "stop moving";

    }
}

contract Car is Vehicle{

    function move () external pure override returns (string memory){

        return "moving forward on road";
    }

    function reverse () external pure returns (string memory){

        return "moving backward on the road";
    }

    function honk () external pure returns(string memory){

        return "Beep Beep";
    }

    function Wipe () external pure returns(string memory){

        return "wiping windscreen";
    }
}