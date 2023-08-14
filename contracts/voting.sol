// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.0;

contract Voting{

int alpha;
int beta;

constructor() public {
   president = 0;
    beta = 0;
}

function getTotalVotesAlpha() view public returns(int) {
    return alpha;
}

function getTotalVotesBeta() view public returns(int){
    return beta;
}

function voteAlpha () public{
    alpha = alpha+1;
}

function voteBeta () public{
    beta = beta+1;
}
}
