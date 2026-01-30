// SPDX-License-Identifier: MIT

pragma solidity 0.8.3;

contract Mammal{

    function warmBlodded () external pure returns(string memory) {

        return "always warm blodded";
    }

    function hairy () external pure returns (string memory){

        return "they have hairs or furs on their body";
    }

    function reproduction () external pure returns(string memory){

        return "the young are born alive, not hatched";
    }

    function feeding () external pure returns(string memory){

        return "after birth the mother feed the young are feed with milk";
    }
}

contract Dog is Mammal{

    function Sound () external pure returns(string memory){

        return "Bark";
    }

    function movement () external pure returns(string memory){

        return "move with 4 limbs";
    }

    function wagTail () external pure returns(string memory){

        return "wagging tail";
    }

}

contract Monkey is Mammal{

    function Sound () external pure returns(string memory){

        return "Scream";
    }

    function movement () external pure returns(string memory){

        return "climbing and swinging with 4 limbs";
    }

    function fifthLimb () external pure returns(string memory){

        return "tip of tail has patch of skin like fingerprint for improved grip";
    }
}