// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0; 
//compiler version
contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;
    // Store Candidates
    // Fetch Candidate
    mapping(uint => Candidate) private candidates;
    // Store Candidates Count
    mapping(uint=>Candidate) public result;
    uint public candidatesCount;
bool public start=false;
bool public end=false;
    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    constructor () {
        addCandidate("Vamsi");
        addCandidate("Ayyappa");
    }
function startElection() public {
  //  require(msg.sender== 'some address');
require(!end);
start=true;
}

function endElection() public{
  //  require(msg.sender== 'some address');
  require(start);
end=true;
getResult();
}

function getResult() public{
    require(end,"Election is not done yet!");
       uint count=1;
       for(count=1;count<=candidatesCount;count++)
        result[count] = Candidate(count, candidates[count].name, candidates[count].voteCount);
}

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
        require(!end);
        require(start);
        // require that they haven't voted before
        require(!voters[msg.sender]);
        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}