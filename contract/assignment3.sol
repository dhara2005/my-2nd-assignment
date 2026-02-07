// SPDX-License-Identifier: MIT

pragma solidity 0.8.3;

contract election{

    address owner; 
    uint256 public candidateNo; 
    uint256 public voterNo; 
    string [] candidateName; 
    bool public isItPaused; 
    uint public totalVotes;

     constructor () {

        owner = msg.sender;

        isItPaused = true;
    }

    struct voter {
        uint256 voterId;
        string voterName;
        uint age;
    }

    voter [] voters;

    // mappings i used 

    mapping (uint => string) candidateById;

    mapping (address => bool) haveVoted;

    mapping (address => bool) haveRegistered;

    mapping (uint => uint) candidateByVote;

    mapping (address => string) votersToCandidate;

    // modifiers i used 

    modifier ownerOnly (){

        require(owner == msg.sender, "Only Owner can call this function");
        _;
    }

    modifier whenNotPaused () {

        require (!isItPaused, "the contract is paused");
        _;
    }

    // events i used 

    event ContestantAdded (uint indexed candidateNo , string candidateName);

    event Registered(uint indexed voterNo , string voterName , address indexed  voterAddress);

    event Voted (uint indexed candidateNo , address voterAddress, uint totalVotes);

    event activity (address indexed by);


    function addContestant (string memory _name) external ownerOnly {

        for (uint i = 0; i < candidateName.length; i++){

            require (keccak256(bytes(_name)) != keccak256(bytes(candidateName[i])), "name has already been added"); // this line of code is to ensure that the owner do not add the same name more than once 
        }

        candidateNo++;

        candidateName.push(_name);

        candidateById[candidateNo] = _name;

        emit ContestantAdded(candidateNo,_name);
    }

    function register (string memory _voterName , uint _age ) external{

       require(!haveRegistered[msg.sender], "user has registered");

       require (_age >= 18, "user age below 18 can't register for the vote");

        voterNo++;

        voters.push(voter(voterNo,_voterName,_age));

        haveRegistered[msg.sender] = true;

         emit Registered(voterNo , _voterName, msg.sender);
    } 

    function viewCandidates () external view whenNotPaused returns(uint [] memory, string [] memory){

        require(candidateNo > 0, "No candidates to view");

        uint[] memory ids = new uint[](candidateNo);
        string[] memory names = new string[](candidateNo);
    
         for(uint i = 0; i < candidateNo; i++) {

            ids[i] = i + 1;       
            names[i] = candidateName[i];
        }   
    
        return (ids, names);
    }

    function vote (uint _candidateNo) external whenNotPaused {

        require(_candidateNo != 0 && _candidateNo <= candidateNo, "there is no contestant with this number");

        require (haveRegistered[msg.sender], "user hasn't registered yet");

        require (!haveVoted[msg.sender],"user has voted already");

        totalVotes++;

        candidateByVote[_candidateNo]++;

        votersToCandidate[msg.sender] = candidateById[_candidateNo];

        haveVoted[msg.sender] = true;

        emit Voted(_candidateNo, msg.sender, totalVotes);
    }

    function revealWinner () external view ownerOnly returns(string memory){

        require(totalVotes > 0, "No one has voted yet");

        uint maxVote;
        uint winningCandidate;
        
      for(uint i = 1; i <= candidateNo; i++){

        if(candidateByVote[i] > maxVote){

            maxVote = candidateByVote[i];

            winningCandidate = i;
        }    
         }

          uint tieCount;

         for(uint i =1; i <= candidateNo; i++){

            if (candidateByVote[i] == maxVote){

                tieCount++;
            }
         }

         if (tieCount > 1){

            return "there has been a tie";
         }
      
      return candidateById[winningCandidate]; 
    }

    function listOfCandidatesVotes () external view ownerOnly returns (string [] memory , uint [] memory){

        require (candidateNo > 0 , "No candidate has been added");

        require (totalVotes > 0, "No one has voted yet");

        uint [] memory votes = new uint[] (candidateNo); 

        for (uint i = 1; i <= candidateNo; i++){

          votes[i -1] = candidateByVote[i];
           
        }

         return (candidateName, votes);
    }

       
    function whoDidIVoteFor () external view returns(string memory){

        require(haveVoted[msg.sender], "user hasn't voted yet");

        return votersToCandidate[msg.sender];
    }

    function toggleActivity () external ownerOnly{

        isItPaused = !isItPaused; // this is to make the contract true if it's false and then false if it's true, a toggle button

        emit activity(msg.sender);
    }
    
    }
