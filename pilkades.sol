// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PilkadesBlockchain {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    address public panitia;
    mapping(uint => Candidate) public candidates;
    uint public candidatesCount;

    mapping(address => bool) public hasVoted;
    
    mapping(address => bool) public isRegistered;

    constructor() {
        panitia = msg.sender;
        addCandidate("Yusuf Islam");
        addCandidate("Raehan Zaki");
        addCandidate("Ade Nafila");
    }

    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function registerVoter(address _voterAddress) public {
        require(msg.sender == panitia, "Hanya panitia yang bisa mendaftarkan warga");
        isRegistered[_voterAddress] = true;
    }

    function castVote(uint _candidateId) public {
        require(isRegistered[msg.sender], "Wallet Anda belum didaftarkan panitia");
        require(!hasVoted[msg.sender], "Anda sudah menggunakan hak suara");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "ID Kandidat tidak sah");

        hasVoted[msg.sender] = true;
        candidates[_candidateId].voteCount++;
    }

    function getResults(uint _candidateId) public view returns (uint) {
        return candidates[_candidateId].voteCount;
    }
}