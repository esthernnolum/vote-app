// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.0;


contract Election {
    //Structure that represents a registered voter in the election
    struct Voter {
        bool isRegistered;
        bool hasVoted; //Whether or not the voter has voted yet
        address delegate; // The address of the delegate that the voter has chosen (default to the voter itself)
        uint256 weight; // Weight of the Voter
        uint256 voteTowards; //States the candidate's ID to which the voter has voted
    }
    
    mapping(uint => address) private voterID; // VoterID mapped to voter address
    mapping(address => Voter) private voters; //address of voter mapped to the voter struct - To view all registered voters
    
    //modifier to check if a voter is a valid voter
    modifier checkIfVoterValid(address owner) {
        require(
            !voters[owner].hasVoted,
            "Voter has already voted."
        );
        require(
            voters[owner].weight > 0,
            "Voter has not been registered or already delegated their vote."
        );
        _;
    }


    //modifier to check if the voter is not yet registered for the addVoter function
    modifier checkNotRegistered(address voter) {
        require(
            !voters[voter].hasVoted && voters[voter].weight == 0 && !voters[voter].isRegistered,
            "Voter has already been registered."
        );
        _;
    }

    //events to be logged into the blockchain
    event AddedAVoter(address voter);
    event VotedSuccessfully(uint256 candidateId);


    // to cast the vote
    function vote(uint256 _ID, address owner)
        public
        checkIfVoterValid(owner)
    {
        voters[owner].hasVoted = true;
        voters[owner].voteTowards = _ID;
        voteCount[_ID] += voters[owner].weight;
        voters[owner].weight = 0;
        emit VotedSuccessfully(_ID);
    }


    // to display result
    function showResults(uint256 _ID)
        public
        view
        checkIfComplete
        returns (
            uint256 id,
            string memory name,
            uint256 count
        )
    {
        return (_ID, voteCount[_ID]);
    }

    function getVoter(uint ID, address owner)  public view checkAdmin(owner)
    returns (
        uint256 id,
        address voterAddress,
        address delegate,
        uint256 weight
    )
    {
        return (
            ID,
            voterID[ID],
            voters[voterID[ID]].delegate,
            voters[voterID[ID]].weight
        );
    }

    function voterProfile(address voterAddress) public view 
    returns (
        uint256 id,
        address delegate,
        uint256 weight,
        uint256 votedTowards,
        string memory name
        )
    {
         
        for(uint256 i = 1; i<= voter_count; i++)
        {
            if(voterAddress == voterID[i])
            {
                return (
                    i,
                    voters[voterID[i]].delegate,
                    voters[voterID[i]].weight,
                    voters[voterID[i]].voteTowards,
                    candidates[voters[voterID[i]].voteTowards].name
                    );
            }
        }
    }

}
