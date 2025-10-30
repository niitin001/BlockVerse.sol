// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Blockverse - A Decentralized Project Registry and Funding Platform
/// @author 
/// @notice This contract allows users to register and fund blockchain-based projects.

contract Project {
    struct ProjectData {
        uint256 id;
        address owner;
        string name;
        string description;
        uint256 funds;
    }

    mapping(uint256 => ProjectData) public projects;
    uint256 public projectCount;

    event ProjectRegistered(uint256 id, string name, address owner);
    event ProjectFunded(uint256 id, uint256 amount, address funder);

    /// @notice Register a new project
    /// @param _name The name of the project
    /// @param _description A short description of the project
    function registerProject(string calldata _name, string calldata _description) external {
        projectCount++;
        projects[projectCount] = ProjectData({
            id: projectCount,
            owner: msg.sender,
            name: _name,
            description: _description,
            funds: 0
        });

        emit ProjectRegistered(projectCount, _name, msg.sender);
    }

    /// @notice Fund an existing project by ID
    /// @param _id The project ID
    function fundProject(uint256 _id) external payable {
        require(_id > 0 && _id <= projectCount, "Invalid project ID");
        require(msg.value > 0, "Funding amount must be greater than 0");

        projects[_id].funds += msg.value;

        emit ProjectFunded(_id, msg.value, msg.sender);
    }

    /// @notice Get project details by ID
    /// @param _id The project ID
    /// @return ProjectData The project struct containing all details
    function getProject(uint256 _id) external view returns (ProjectData memory) {
        require(_id > 0 && _id <= projectCount, "Project does not exist");
        return projects[_id];
    }
}

