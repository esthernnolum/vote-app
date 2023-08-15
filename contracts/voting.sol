#version of Solidity 
pragma solidity ^0.5.0;

contract Voting{

int presidential;
int gubernatorial;
int localGovernment;

constructor() public {
    presidential  = 0;
    gubernatorial = 0;
    localGovernment = 0;
}

function getTotalVotesAlpha() view public returns(int) {
    return presidential;
}

function getTotalVotesBeta() view public returns(int){
    return gubernatorial;
}

function getTotalVotesBeta() view public returns(int){
    return localGovernment;
}

function voteAlpha () public{
    presidential = presidential+1;
}

function voteBeta () public{
    gubernatorial = gubernatorial+1;
}

function voteBeta () public{
    localGovernment = localGovernment+1;
}
}

