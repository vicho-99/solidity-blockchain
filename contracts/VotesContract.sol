// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract VotesContract {

    address public seller;

    uint256 public countCandidate = 0;
    uint256 public countVoters = 0;

    struct Candidate {
        uint256 id;
        string name;
        uint256 total;
    }

    struct Voter {
        uint256 id;
    }

    mapping (uint256 => Candidate) public candidates;
    mapping (uint256 => Voter) public voters;

    constructor() {
        createCandidate(0,"Juan Soto");
        createCandidate(1,"Maria Lopez");
        createCandidate(2,"Pedro Ramirez"); 
    }

    function createCandidate(uint256 _id , string memory name ) public  {
        candidates[_id] = Candidate(_id,name,0);
        countCandidate++;
    }

    function registerVoter(uint256 _id ) public  {
        voters[countVoters] = Voter(_id);
        countVoters++;
    }

    function saveVote(uint256 _idCandidate , uint256 _idVoter  ) public  {

        if(!validateCandidate(_idCandidate)){
            require(
                msg.sender == seller,
                "No se encuentra el candidato indicado."
            );
        }

        if(validateVoter(_idVoter)){
            require(
                msg.sender == seller,
                "Voto ya registrado por el usuario ingresado."
            );
        }

    
        for (uint256 index = 0; index < countCandidate; index++) {
            
            if(candidates[index].id == _idCandidate){

                Candidate memory _candidate = candidates[_idCandidate];
                _candidate.total = _candidate.total + 1;
                candidates[_idCandidate] = _candidate;

                registerVoter(_idVoter);
               
            }
        }

    }

    function countCandidateVotes(uint256 _idCandidate) public view returns (uint)  {

        uint totalVotes = 0;
        
        for (uint256 index = 0; index < countCandidate; index++) {
                
            if(candidates[index].id == _idCandidate){
                Candidate memory _candidate = candidates[_idCandidate];
                totalVotes = _candidate.total;
            }
        }

      return totalVotes;

    }

    function countVotesTotal() public view returns (uint)  {

        uint totalVotes = 0;

        for (uint256 index = 0; index < countCandidate; index++) {
        
            Candidate memory _candidate = candidates[index];
            totalVotes = totalVotes + _candidate.total;

        }

      return totalVotes;

    }

    function validateVoter( uint256 _idVoter)  public   view returns (bool) {

        bool result = false;

        for (uint256 index = 0; index < countVoters; index++) {
            
            if(voters[index].id == _idVoter){
                result = true;
            }

        }

        return result;
    }

    function validateCandidate(uint256 _idCandidate ) public   view returns (bool) {

        bool result = false;

        for (uint256 index = 0; index < countCandidate; index++) {
            
            if(candidates[index].id == _idCandidate){
                result = true;
            }

        }

        return result;

    }

}