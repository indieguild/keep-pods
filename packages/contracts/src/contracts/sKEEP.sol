pragma solidity >=0.4.22 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract sKeep is ERC20Burnable, Ownable {

    
    constructor(_owner) ERC20Burnable('Staked Keep Token', 'sKEEP') public {
        
    }
     function mint(address to, uint256 amount) public onlyOwner{
        // Only owners can mint
        require(owner, "DOES_NOT_HAVE_MINTER_ROLE");

        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyOwner{
        // Only owners can burn
        require(owner, "DOES_NOT_HAVE_BURNER_ROLE");

       _burn(from, amount);
    }
  
}